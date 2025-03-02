# ------------------------------------------------------------------------
# Copyright 2023 The Aerospace Corporation
#
# This file is part of SatCat5.
#
# SatCat5 is free software: you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the
# Free Software Foundation, either version 3 of the License, or (at your
# option) any later version.
#
# SatCat5 is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
# License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with SatCat5.  If not, see <https://www.gnu.org/licenses/>.
# ------------------------------------------------------------------------
#
# This script packages a Vivado IP core: satcat5.port_sgmii_lvds
#
# Default reference clock frequency 625MHz, can be overridden
# to one of 125, 156.25, 625 (only 625 implemented so far)
# Note - KCU105 build using the 125 MHz clock did not work for
# unknown reasons.  Using the SGMII 625 MHz clock did work so
# leaving as the only supported clock frequency until others
# are verified in hardware.

set VALID_FREQS {"125" "156.25" "625"}
if ![info exists refclk_freq_mhz] {
    set refclk_freq_mhz 625
    puts "No refclk_freq_mhz specified, defaulting to $refclk_freq_mhz"
}
if {[lsearch -exact $VALID_FREQS $refclk_freq_mhz] < 0} {
    error "ERROR: $refclk_freq_mhz not one of allowed freqs: $VALID_FREQS"
}

if {$refclk_freq_mhz != "625"} {
    error "ERROR: port_sgmii_lvds only supports 625 MHz for now. $refclk_freq_mhz is not implemented."
}

# Create a basic IP-core project.
set ip_name "port_sgmii_lvds"
set ip_vers "1.0"
set ip_disp "SatCat5 SGMII PHY (LVDS)"
set ip_desc "SatCat5 SGMII port using LVDS-SERDES."

set ip_root [file normalize [file dirname [info script]]]
source $ip_root/ipcore_shared.tcl

# Create the underlying LVDS-to-SGMII IP-core.
source $ip_root/../generate_sgmii_lvds.tcl
generate_sgmii_lvds sgmii_lvds0 true $refclk_freq_mhz
ipcore_add_xci sgmii_lvds0

# Add all required source files:
ipcore_add_file $src_dir/common/*.vhd
ipcore_add_file $src_dir/xilinx/port_sgmii_lvds.vhd
ipcore_add_top  $ip_root/wrap_port_sgmii_lvds.vhd

# Connect everything
ipcore_add_ethport Eth sw master
ipcore_add_refopt PtpRef tref
ipcore_add_reset reset_p ACTIVE_HIGH

# Set parameters
set refclk_freq_hz [expr {round($refclk_freq_mhz * 1000000)}]
ipcore_add_param AUTONEG_EN bool true\
    {Enable Auto-Negotiation? Typically enabled with the exception of SFP to RJ45 modules.}
ipcore_add_param REFCLK_FREQ_HZ string $refclk_freq_hz\
    {Frequency of SGMII reference clock in Hz, must be 125, 156.25, or 625 MHz} false

# Connect the reference clock.
set intf [ipx::add_bus_interface REFCLK $ip]
set_property abstraction_type_vlnv xilinx.com:interface:diff_clock_rtl:1.0 $intf
set_property bus_type_vlnv xilinx.com:interface:diff_clock:1.0 $intf
set_property interface_mode slave $intf
set_property physical_name refclk_p   [ipx::add_port_map REFCLK_P $intf]
set_property physical_name refclk_n   [ipx::add_port_map REFCLK_N $intf]
set_property value $refclk_freq_hz    [ipx::add_bus_parameter FREQ_HZ $intf]

# Connect the LVDS I/O (SGMII) port.
set intf [ipx::add_bus_interface SGMII $ip]
set_property abstraction_type_vlnv xilinx.com:interface:sgmii_rtl:1.0 $intf
set_property bus_type_vlnv xilinx.com:interface:sgmii:1.0 $intf
set_property interface_mode master $intf

set_property physical_name sgmii_rxp    [ipx::add_port_map RXP  $intf]
set_property physical_name sgmii_rxn    [ipx::add_port_map RXN  $intf]
set_property physical_name sgmii_txp    [ipx::add_port_map TXP  $intf]
set_property physical_name sgmii_txn    [ipx::add_port_map TXN  $intf]

# Package the IP-core.
ipcore_finished
