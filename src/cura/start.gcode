; Ender 3 Max Custom Start G-code
; {material_bed_temperature}
; {material_print_temperature}

M140 S{material_bed_temperature_layer_0} ; Start heating bed
M104 S{material_print_temperature_layer_0} ; Start heating hotend
M109 S{material_print_temperature_layer_0} ; Wait for hotend to reach temp before proceeding

G92 E0 ; Reset Extruder
G28 ; Home all axes

M190 S{material_bed_temperature_layer_0} ; Wait for bed to reach temp before proceeding

M420 S1 ; load last-saved mesh
; G29 ; Level Bed

; M300 S1000 P500 ; chirp to indicate starting to print

G1 Z2.0 F3000 ; Move Z Axis up little to prevent scratching of Heat Bed
G1 X0.1 Y20 Z0.3 F5000.0 ; Move to start position
G1 X0.1 Y200.0 Z0.3 F1500.0 E15 ; Draw the firstine
G1 X0.4 Y200.0 Z0.3 F5000.0 ; Move to side a little
G1 X0.4 Y20 Z0.3 F1500.0 E30 ; Draw the second line
G1 Z2.0 F3000 ; Move Z Axis up little to prevent scratching of Heat Bed
G92 E0 ; Reset Extruder
G1 X5 Y20 Z0.3 F5000.0 ; Move over to prevent blob squish
G92 E0 ; Reset Extruder
