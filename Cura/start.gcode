; Ender 3 Custom Start G-code
G92 E0 ; Reset Extruder

M140 S{material_bed_temperature_layer_0} ; Start heating bed
M190 S{material_bed_temperature_layer_0} ; Wait for bed to reach temp before proceeding

G28 ; Home all axes
M104 S{material_print_temperature_layer_0} ; Start heating extruder

; G29 ; Level Bed
; M420 S1 ; Load bed mesh - marlin - NOTE: Level bed first and SAVE - issue M500 after leveling, then print.


G1 Z1.0 F3000 ; Move Z Axis up little to prevent scratching of Heat Bed
M109 S{material_print_temperature_layer_0} ; Wait for extruder to reach temp before proceeding

G1 X0.1 Y20 Z0.3 F5000.0 ; Move to start position
G1 X0.1 Y200.0 Z0.3 F1500.0 E15 ; Draw the firstine
G1 X0.4 Y200.0 Z0.3 F5000.0 ; Move to side a little
G1 X0.4 Y20 Z0.3 F1500.0 E30 ; Draw the second line
G92 E0 ; Reset Extruder
G1 Z2.0 F3000 ; Move Z Axis up little to prevent scratching of Heat Bed
G1 X5 Y20 Z0.3 F5000.0 ; Move over to prevent blob squish