# Copyright 2022 The Aerospace Corporation
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

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Tracked Phase Error}
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 10.0 -min -10.0 /ptp_counter_tb/uut0/sync_delta
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 10.0 -min -10.0 /ptp_counter_tb/uut1/sync_delta
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 10.0 -min -10.0 /ptp_counter_tb/uut2/sync_delta
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 10.0 -min -10.0 /ptp_counter_tb/uut3/sync_delta
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 10.0 -min -10.0 /ptp_counter_tb/uut4/sync_delta
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 10.0 -min -10.0 /ptp_counter_tb/uut5/sync_delta
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 10.0 -min -10.0 /ptp_counter_tb/uut6/sync_delta
add wave -noupdate -divider {Tracked Frequency}
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 10000000.0 -min -10000000.0 -radix decimal /ptp_counter_tb/uut0/uut_sync/p_sim/dtau
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 10000000.0 -min -10000000.0 -radix decimal /ptp_counter_tb/uut1/uut_sync/p_sim/dtau
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 10000000.0 -min -10000000.0 -radix decimal /ptp_counter_tb/uut2/uut_sync/p_sim/dtau
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 10000000.0 -min -10000000.0 -radix decimal /ptp_counter_tb/uut3/uut_sync/p_sim/dtau
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 10000000.0 -min -10000000.0 -radix decimal /ptp_counter_tb/uut4/uut_sync/p_sim/dtau
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 10000000.0 -min -10000000.0 -radix decimal /ptp_counter_tb/uut5/uut_sync/p_sim/dtau
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 10000000.0 -min -10000000.0 -radix decimal /ptp_counter_tb/uut6/uut_sync/p_sim/dtau
add wave -noupdate -divider {Lock/unlock status}
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 1023.0 -min -0.0 -radix unsigned /ptp_counter_tb/uut0/uut_sync/lock_ctr
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 1023.0 -min -0.0 -radix unsigned /ptp_counter_tb/uut1/uut_sync/lock_ctr
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 1023.0 -min -0.0 -radix unsigned /ptp_counter_tb/uut2/uut_sync/lock_ctr
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 1023.0 -min -0.0 -radix unsigned /ptp_counter_tb/uut3/uut_sync/lock_ctr
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 1023.0 -min -0.0 -radix unsigned /ptp_counter_tb/uut4/uut_sync/lock_ctr
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 1023.0 -min -0.0 -radix unsigned /ptp_counter_tb/uut5/uut_sync/lock_ctr
add wave -noupdate -clampanalog 1 -format Analog-Step -height 80 -max 1023.0 -min -0.0 -radix unsigned /ptp_counter_tb/uut6/uut_sync/lock_ctr
add wave -noupdate -divider {Acquisition status}
add wave -noupdate /ptp_counter_tb/uut0/uut_sync/pll_midx
add wave -noupdate /ptp_counter_tb/uut0/uut_sync/pll_mode
add wave -noupdate /ptp_counter_tb/uut0/uut_sync/lock_any
add wave -noupdate /ptp_counter_tb/uut1/uut_sync/pll_midx
add wave -noupdate /ptp_counter_tb/uut1/uut_sync/pll_mode
add wave -noupdate /ptp_counter_tb/uut1/uut_sync/lock_any
add wave -noupdate /ptp_counter_tb/uut2/uut_sync/pll_midx
add wave -noupdate /ptp_counter_tb/uut2/uut_sync/pll_mode
add wave -noupdate /ptp_counter_tb/uut2/uut_sync/lock_any
add wave -noupdate /ptp_counter_tb/uut3/uut_sync/pll_midx
add wave -noupdate /ptp_counter_tb/uut3/uut_sync/pll_mode
add wave -noupdate /ptp_counter_tb/uut3/uut_sync/lock_any
add wave -noupdate /ptp_counter_tb/uut4/uut_sync/pll_midx
add wave -noupdate /ptp_counter_tb/uut4/uut_sync/pll_mode
add wave -noupdate /ptp_counter_tb/uut4/uut_sync/lock_any
add wave -noupdate /ptp_counter_tb/uut5/uut_sync/pll_midx
add wave -noupdate /ptp_counter_tb/uut5/uut_sync/pll_mode
add wave -noupdate /ptp_counter_tb/uut5/uut_sync/lock_any
add wave -noupdate /ptp_counter_tb/uut6/uut_sync/pll_midx
add wave -noupdate /ptp_counter_tb/uut6/uut_sync/pll_mode
add wave -noupdate /ptp_counter_tb/uut6/uut_sync/lock_any
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2488573701 ps} 0}
configure wave -namecolwidth 283
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {3730458375 ps}
