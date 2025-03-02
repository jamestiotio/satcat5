# ------------------------------------------------------------------------
# Copyright 2019, 2020, 2021, 2023 The Aerospace Corporation
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
# This script creates a new Vivado project for the Prototype V1 target
# (AC701 + custom I/O board) in the "base" (RMII) configuration.
# To re-create the project, source this file in the Vivado Tcl Shell.
#

# Change to example project folder.
cd [file normalize [file dirname [info script]]]

# Set project-level properties.
set target_part "xc7a200tfbg676-2"
set target_proj "switch_proto_v1_base"
set target_top "switch_top_ac701_base"
set constr_synth "switch_proto_v1_base_synth.xdc"
set constr_impl "switch_proto_v1_base_impl.xdc"

# List HDL source files, grouped by type.
set files_main [list \
 "[file normalize "../../src/vhdl/common/*.vhd"]"\
 "[file normalize "../../src/vhdl/xilinx/7series_*.vhd"]"\
 "[file normalize "../../src/vhdl/xilinx/scrub_xilinx.vhd"]"\
 "[file normalize "./switch_top_ac701_base.vhd"]"\
]

# Run the main script.
source ../../project/vivado/shared_create.tcl

# Execute the build and write out the .bin file.
source ../../project/vivado/shared_build.tcl
satcat5_launch_run
satcat5_write_bin $target_top.bin
