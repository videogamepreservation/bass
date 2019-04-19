;include_macros	equ	1
include_struc	equ	1
include_sequates	equ	1
include_scripts	equ	1
include_files	equ	1
include_logic	equ	1
	include include.asm

ifndef s1_demo

;start32save_data


;data_4	dd	0 dup (0)

	include 30comp.inc
	include 31comp.inc
	include 32comp.inc
	include 33comp.inc
	include 34comp.inc

	include 36comp.inc
	include 37comp.inc
	include 38comp.inc
	include 39comp.inc
	include 40comp.inc
	include 41comp.inc
	include 42comp.inc

	include 44comp.inc
	include 45comp.inc
	include 46comp.inc
	include 47comp.inc
	include 48comp.inc

	include 65comp.inc


;end32save_data

endif
	end

