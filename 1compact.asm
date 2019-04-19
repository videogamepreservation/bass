;include_macros	equ	1
include_struc	equ	1
include_sequates	equ	1
include_scripts	equ	1
include_files	equ	1
include_logic	equ	1
	include include.asm




;start32save_data


;data_1	dd 0 dup (0)
	include 0compact.inc
	include 1compact.inc
	include 2compact.inc
	include 3compact.inc
	include 4compact.inc

;end32save_data
	end

