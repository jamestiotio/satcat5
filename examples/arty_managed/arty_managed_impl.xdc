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

# Implemenation constraints for arty_managed
# This file is for added constraints required ONLY during implementation.

#####################################################################
### Bitstream generation

set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design];
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design];
set_property CONFIG_MODE SPIx4 [current_design];


#####################################################################
### Timing constraints

# 100 MHz clock reference
create_clock -period 10.000 -name clk_ref [get_ports ext_clk100];

# Mark all input clocks as mutually asynchronous, including synchronous
# clocks for which we've designed explicit clock-domain-crossings.
# (Same as adding calling set_false_path on all pairwise permutations.)
# See also: https://www.xilinx.com/support/answers/44651.html
set_clock_groups -asynchronous -group [get_clocks clk_ref -include_generated_clocks];

# Explicit delay constraints on clock-crossing signals.
set_max_delay -datapath_only 5.0 -from [get_cells -hier -filter {satcat5_cross_clock_src > 0}]
set_max_delay -datapath_only 5.0 -to   [get_cells -hier -filter {satcat5_cross_clock_dst > 0}]
