;include_macros	equ	1
include_struc	equ	1
include_sequates	equ	1
include_scripts	equ	1
include_files	equ	1
include_logic	equ	1
	include include.asm


ifndef s1_demo

;start32save_data


	include 10comp.inc
	include 11comp.inc

	include 19comp.inc
	include 20comp.inc
	include 21comp.inc
	include 22comp.inc
	include 23comp.inc
	include 24comp.inc
	include 25comp.inc
	include 26comp.inc
	include 27comp.inc
	include 28comp.inc

;data_3	dd 0 dup (0)
	include 29comp.inc

;end32save_data

endif
	end

