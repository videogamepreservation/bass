;--------------------------------------------------------------------------------------------------pointer macros

dpt	equ	dword ptr
wpt	equ	word ptr
bpt	equ	byte ptr


;--------------------------------------------------------------------------------------------------clear register

;	Clear a register

clear	macro	reg
	xor	reg,reg
endm

;--------------------------------------------------------------------------------------------------conditional jumps

;	Jump if register=0

jife	macro	reg,label
	or	reg,reg
	je	label
endm

;	Jump if regester!=0

jifne	macro	reg,label
	or	reg,reg
	jne	label
endm

;--------------------------------------------------------------------------------------------------fast loop macro

floop	macro one,two

;	It appears that dec reg, jne is faster than loop!
;	loop		11+m
;	dec	reg32	2
;	jne		7+m

ifnb <two>	;form floop register,label
	dec	one
	jne	two

else	;form floop label (register=ecx)
	dec	ecx
	jne	one
endif
endm

;--------------------------------------------------------------------------------------------------fetch_compact

fetch_compact	macro reg

;	Load a register with a compact address

ifndef fetch_compact_esi
	extrn	fetch_compact_esi:near
endif

ifnb <reg>
	push	esi
endif
	call	fetch_compact_esi
ifnb <reg>
	mov	reg,esi
	pop	esi
endif
endm


;--------------------------------------------------------------------------------------------------Dos interrupts

screen_int	macro

	int	10h

endm

dos_int	macro

	int	21h

endm

disk_int	macro

	int	21h

endm

mouse_int	macro num

	mov	ax,num

	int	33h

endm



program_error	macro num
ifndef error_routine
	extrn	error_routine:near
endif
	mov	eax,num
	call	error_routine

endm

;--------------------------------------------------------------------------------------------------lodsd lookalike


flodsd	macro dest,source

	mov	dest,dword ptr [source]
	add	source,4
endm

flodsws	macro	dest,source	;load word register

	mov	dest,word ptr [source]
	add	source,2
endm

flodswl	macro	dest,source	;load long register from word

	movzx	dest,word ptr [source]
	add	source,2
endm


;--------------------------------------------------------------------------------------------------fetch_item

fetch_item	macro	dest,source

ifnb<source>
	mov	dest,[offset item_list+source*4]
else
ifnb <dest>
	mov	dest,[offset item_list+eax*4]
else
	mov	esi,[offset item_list+eax*4]
endif
endif
endm


;--------------------------------------------------------------------------------------------------push_all

push_all	macro
	push	ds
	push	es
	pushad
endm

pop_all	macro
	popad
	pop	es
	pop	ds
endm


;--------------------------------------------------------------------------------------------------


load_fixed	macro num

	mov	eax,num
	clear	edx
	call	load_file
	mov	[item_list + num * 4],eax
endm


;--------------------------------------------------------------------------------------------------

open_file	macro name,error_mes
	local err_lab

	mov	ax,3d00h
	mov	edx,offset name
	disk_int
	jnc	err_lab

	program_error error_mes

err_lab:
endm

close_file	macro

	mov	ah,3eh
	disk_int
endm


;--------------------------------------------------------------------------------------------------load_to

load_to	macro num,dest

	mov	eax,num
	clear	edx
	call	load_file
	mov	dest,eax

endm

free_clr2	macro addr

	mov	eax,addr
	call	my_free
	mov	addr,0

endm


free_if_n0	macro addr
	local	not_aloc

	mov	eax,[addr]
	jife	eax,not_aloc
	call	my_free
	mov	[addr],0
not_aloc:

endm
