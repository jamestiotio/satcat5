# ------------------------------------------------------------------------
# Copyright 2021, 2022 The Aerospace Corporation
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
# This script packages a Vivado IP core: satcat5.cfgbus_split
#

# Create a basic IP-core project.
set ip_name "cfgbus_split"
set ip_vers "1.0"
set ip_disp "SatCat5 ConfigBus Splitter"
set ip_desc "Splitter/combiner for ConfigBus interfaces."

variable ip_root [file normalize [file dirname [info script]]]
source $ip_root/ipcore_shared.tcl

# Add all required source files:
ipcore_add_file $src_dir/common/*.vhd
ipcore_add_top  $ip_root/wrap_cfgbus_split.vhd

# Add the upstream port.
ipcore_add_cfgbus Cfg cfg slave

# Set parameters
set pcount [ipcore_add_param PORT_COUNT long 3 \
    {Number of ConfigBus peripherals}]
ipcore_add_param DLY_BUFFER bool false \
    {Add a delay buffer for improved timing?}

# Set min/max range on the PORT_COUNT parameter.
set PORT_COUNT_MAX 16
set_property value_validation_type range_long $pcount
set_property value_validation_range_minimum 1 $pcount
set_property value_validation_range_maximum $PORT_COUNT_MAX $pcount

# Add each of the downstream ports with logic to show/hide.
# (HDL always has PORT_COUNT_MAX, enable first N depending on GUI setting.)
for {set idx 0} {$idx < $PORT_COUNT_MAX} {incr idx} {
    set name [format "Port%02d" $idx]
    set port [format "p%02d" $idx]
    set intf [ipcore_add_cfgbus $name $port master]
    set_property enablement_dependency "$idx < \$PORT_COUNT" $intf
}

# Package the IP-core.
ipcore_finished
