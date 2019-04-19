;include_macros	equ	1
;include_struc	equ	1
include_sequates	equ	1
include_scripts	equ	1
include_files	equ	1
include_logic	equ	1
	include include.asm




;start32save_data

;data_0	dd 0 dup (0)
	include z_compac.inc
	include objects.inc
	include 101comp.inc
	include 102comp.inc
	include 85comp.inc



;pconly_f_r3_1	equ	0
;pconly_f_r3_2	equ	0



;end32save_data
	end
