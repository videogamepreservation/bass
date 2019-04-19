;include_macros	equ	1
include_struc	equ	1
include_sequates	equ	1
include_scripts	equ	1
include_files	equ	1
include_logic	equ	1
	include include.asm



ifndef s1_demo

;start32save_data

;data_6	dd 0 dup (0)
	include 90comp.inc
	include 91comp.inc
	include 92comp.inc
	include 93comp.inc
	include 94comp.inc
	include 95comp.inc
	include 96comp.inc

	include lincmenu.inc
	include linc_gen.inc

;end32save_data

endif
	end

