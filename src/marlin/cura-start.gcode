; --- Ender 3 Max Custom Start G-code ---
; Works with BLTouch or CR Touch + Marlin firmware
; Automatically levels bed, fades corrections, and draws purge line
; Bed: {material_bed_temperature_layer_0}
; Nozzle: {material_print_temperature_layer_0}

; --- Setup positioning modes and safety ---
G90                     ; Use absolute positioning for X, Y, Z (standard mode)
M82                     ; Use absolute mode for the extruder (Cura expects this)
M107                    ; Turn off part-cooling fan just in case it's left on

; --- Heat bed first (best for leveling consistency) ---
M140 S{material_bed_temperature_layer_0}           ; Start heating the bed, but don't wait
M104 S150                                           ; Preheat nozzle to 150°C to prevent oozing during homing/probing
M190 S{material_bed_temperature_layer_0}           ; Wait for the bed to reach target temperature before continuing

; --- Home and auto-bed-level ---
G28                     ; Home all axes (X, Y, Z) to establish zero positions
G29                     ; Run auto bed leveling using BLTouch / CR Touch to create new mesh
M420 Z10                ; Enable the mesh and fade leveling corrections over the first 10 mm of print height

; --- Finish heating nozzle and prepare to print ---
M104 S{material_print_temperature_layer_0}         ; Set final nozzle temperature (start heating)
G92 E0                  ; Reset extruder distance to zero
G1 Z5 F3000             ; Raise nozzle 5 mm to avoid scraping while waiting
M109 S{material_print_temperature_layer_0}         ; Wait for nozzle to reach final printing temperature

; --- Purge line to prime nozzle ---
G1 X2 Y10 F5000         ; Move to purge start position near front-left (clear of bed clips)
G1 Z0.28 F3000          ; Lower to first-layer height
G1 X2 Y200 E15 F1500    ; Draw a straight purge line while extruding filament
G1 X2.4 Y200 F5000      ; Move sideways slightly
G1 X2.4 Y10 E30 F1500   ; Draw a second purge line for consistent flow
G92 E0                  ; Reset extruder again so future extrusion starts cleanly
G1 Z2 F3000             ; Lift nozzle to prevent dragging
G1 X5 Y20 F5000         ; Move away from purge area to a safe start position

; --- Ready to print ---
; (Cura will insert the sliced model G-code after this)
