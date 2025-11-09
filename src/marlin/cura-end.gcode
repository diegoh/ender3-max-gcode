; --- Ender 3 Max Custom End G-code ---
; Safe shutdown + Zelda Fanfare :)

M400                    ; Wait for moves to finish
G92 E0                  ; Reset extruder
G1 E-3 F300             ; Retract 3 mm of filament

; --- Move print head & bed safely ---
G91                     ; Relative positioning
G1 Z10 F3000            ; Raise Z by 10 mm
G90                     ; Absolute positioning
G1 X0 Y230 F3000        ; Move bed forward for easy part removal

; --- Power down heaters & fans ---
M104 S0                 ; Turn off hotend
M140 S0                 ; Turn off bed
M106 S0                 ; Turn off part cooling fan
M84                     ; Disable stepper motors

; --- Zelda "Discovery" Fanfare ---
M300 S784 P150    ; G5
M300 S1047 P150   ; C6
M300 S1568 P300   ; G6
M300 S2093 P400   ; C7
M300 S0 P200      ; pause
M300 S1568 P300   ; G6
M300 S2093 P400   ; C7
M300 S0 P250      ; short pause
M300 S1047 P300   ; C6
M300 S1568 P300   ; G6
M300 S2093 P600   ; C7

M117 Print complete! 🎉
; --- End of G-code ---