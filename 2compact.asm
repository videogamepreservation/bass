;include_macros	equ	1
include_struc	equ	1
include_sequates	equ	1
include_scripts	equ	1
include_files	equ	1
include_logic	equ	1
	include include.asm

ifndef s1_demo


;start32save_data

;data_2	dd 0 dup (0)
	include 5compact.inc

	include 9compact.inc

	include 12comp.inc
	include 13comp.inc
	include 14comp.inc
	include 15comp.inc
	include 16comp.inc
	include 17comp.inc
	include 18comp.inc

;end32save_data

endif
	end

