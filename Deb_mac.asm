
;	Debugging macros


;--------------------------------------------------------------------------------------------------Debug a compact

debug_compact	macro	reg,message,address
	local label1,label2

ifdef debug_42
end32code
start32data
ifndef _debug_flag
	extrn	_debug_flag:dword
endif

label1	db	message
	db	0

end32data
start32code
	extrn	_debug_compact__Npcpcpc:near

	push_all
	bt	[_debug_flag],df_debug
	jc	label2
	push	reg
	push	offset label1
ifnb<address>
	push	offset address
else
	push	0
endif
	call	_debug_compact__Npcpcpc
label2:	pop_all
endif
endm

proc_start	macro name

name	proc

	push	ebp
	mov	ebp,esp
	push	ebx
	push	esi
	push	edi
endm

proc_end	macro name,ret_val

	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret	ret_val

name	endp

endm


;--------------------------------------------------------------------------------------------------cherror

cherror	macro	reg1,cond,reg2,err_mess
	local label1,label2
ifdef debug_42
	cmp	reg1,reg2
	j&cond	label1
	jmp	label2
label1:	program_error err_mess
	nop
label2:
endif
endm


;--------------------------------------------------------------------------------------------------debug_route
debug_route	macro
	local	no_debug
ifdef ar_debug

ifndef _debug_flag
end32code
start32data
	extrn	_debug_flag:dword
end32data
start32code
endif

	push_all
	bt	[_debug_flag],df_ar
	jnc	no_debug
	push	[route_grid]
	call	_debug_route_grid__Nps
no_debug:	pop_all

endif

endm


;--------------------------------------------------------------------------------------------------printf

printf	macro format,a,b,c,d
	local	form_data,no_debug
ifdef debug_42							;only compile if debug option set

ifndef debug_printf__Bpce						;Ensure printf routine declared
	extrn	_debug_printf__Bpce:near
endif

end32code
start32data
;ifndef _debug_flag
;	extrn	_debug_flag:dword
;endif
form_data	db	format					;put string into data segment
	db	0
end32data

start32code
	push_all					;save everything
	pushf
	cld
;	bt	[_debug_flag],df_debug
;	jc	no_debug
ifnb<d>
	push	d
endif
ifnb<c>
	push	c
endif
ifnb<b>
	push	b
endif
ifnb<a>
	push	a
endif
	push	offset form_data
	call	_debug_printf__Bpce
ifnb<d>
	lea	esp,4[esp]
endif
ifnb<c>
	lea	esp,4[esp]
endif
ifnb<b>
	lea	esp,4[esp]
endif
ifnb<a>
	lea	esp,4[esp]
endif
	lea	esp,4[esp]
;no_debug:
	popf
	pop_all
endif
endm


;--------------------------------------------------------------------------------------------------


inform_debug	macro cond,text,more

;	If a conditional enabled then print a message to the user

ifdef &cond						;if conditional on

end32code
start32data
&cond&_text	db	text,13,10,0			;text + \n
end32data
start32code
ifndef _printf
	extrn	_printf:near
endif
ifnb<more>
	push	more
endif
	push	offset &cond&_text
	call	_printf				;print text
ifnb<more>
	lea	esp,8[esp]
else
	lea	esp,4[esp]
endif
inform_debug_on	equ	1				;enable wait for key code
endif

endm


show_files	macro text,reg

ifdef debug_42
	
	push	eax
	push	ebx
	push	ecx
ifnb <reg>
	mov	eax,reg
endif
	mov	ebx,eax
	mov	ecx,eax
	shr	ecx,11
	and	ebx,2047
	printf text,ecx,ebx,eax

	pop	ecx
	pop	ebx
	pop	eax
endif

endm

;--------------------------------------------------------------------------------------------------

ifdef mem_check

free_fixed_item	macro num

	mov	eax,[item_list + num * 4]
	call	my_free
endm

endif

;--------------------------------------------------------------------------------------------------border


border	macro col

ifdef debug_42
	push	eax
	push	edx
	mov	dx,3DAh
	in	al,dx
	mov	dx,3C0h
	mov	al,11h
	out	dx,al
	mov	al,col
	out	dx,al
	mov	al,20h
	out	dx,al
	pop	edx
	pop	eax
endif

endm


;--------------------------------------------------------------------------------------------------call_address

call_address	macro

ifdef debug_42
	push	ebp
	mov	ebp,esp
	push	eax
	mov	eax,4[ebp]
	printf "call address %x",eax
	pop	eax
	pop	ebp
endif

endm
