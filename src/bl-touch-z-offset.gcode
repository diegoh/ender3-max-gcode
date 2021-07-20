G28 ; Home all axes
M851 Z0 ; Clear Z-offset

M500 ; Save Settings
M501 ; Reload Settings
; M503 ; Read Settings

G28 Z0; Home Z-axis to 0

M211 S0 ; Disable Z-axis safety measures to allow negative values

; Position Z-axis to the desired location
; Lower the Z-axis until it is at the desired position using printer's interface or a tool like OctoPrint or Pronterface.
; Take note of the `Z-value` (Usually negative).

M851 Z-2 ; -2 is just an example ; Set the Z-offset using the `Z-value` noted above `M851 Z<offset>
M211 S1 ; Enable Z-axis safety measures

M500 ; Store Settings
M501 ; Reload Settings
; M503 ; Read Settings

; NOTE on bed-levelling
; Homing can disable bed-levelling
; Run `M420 S1` to enable it or `M420 S0` to disable it
; Alternatively use RESTORE_LEVELING_AFTER_G28 in the firmware settings (Configuration.h)
