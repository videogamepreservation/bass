include_macros	equ	1
	include include.asm


start32data

dump_name	db	"sky"
dn_h	db	"0"
dn_t	db	"0"
dn_u	db	"0"
	db	".anm",0

screen_copy	dd	0
screen_ptr	dd	0

lpf_data1	db	"LPF "
	dw	256,1		;maxlps, no frames
	dd	1		;no records
	dw	256		;maxrecsperlp
	dw	1280		;lpftableoffset
	db	"ANIM"
	dw	320		;width
	dw	200		;height
	db	0		;variant
	db	0		;version
	db	0		;haslastdelta
	db	0		;lastdeltavalid
	db	0		;pixel type
	db	1		;compressiontype
	db	0		;otherrecsperfrm
	db	1		;bitmaptype
lpf_data1_end	db	0 dup (0)

;	db	32 dup (0)	;recordtypes

lpf_data2	dd	1		;nframes
	dw	20		;framespersecond
lpf_data2_end	db	0 dup (0)

;	db	29*2 dup (0)	;pad
;
;	db	128 dup (0)	;cycles

;	db	1024 dup (0)	;palette

lpf_data3	dw	0,1,64019	;lpf table
lpf_data3_end	db	0 dup (0)

;	dw	255*3 dup (0)

lpf_data4	dw	0,1,64019,0,64019	;frame header

	dd	10042h

lpf_data4_end	db	0 dup (0)

;	dw	0ff80h
;	db	0bfh
;	db	16383 dup (7)	;pixels
;
;	dw	0ff80h
;	db	0bfh
;	db	16383 dup (8)	;pixels
;
;	dw	0ff80h
;	db	0bfh
;	db	16383 dup (9)	;pixels
;
;	dw	380h
;	db	0bah
;	db	14851 dup (10)	;pixels
;
;	db	80h
;	dw	0
;
;	db	1507 dup (0)	;pad to 65k

data_16383	dw	0ff80h
	db	0bfh

data_14851	dw	380h
	db	0bah

data_end	db	80h
	dw	0

end32data


start32code


do_screen_dump	proc

;	Make a copy of the screen

	mov	eax,64000
	call	my_malloc
	mov	[screen_copy],eax
	mov	[screen_ptr],eax

	mov	edi,eax					;clear an area to use for writing
	mov	ecx,2000/4
	clear	eax
	rep	stosd

try_file:	mov	edx,offset dump_name
	mov	ax,3d00h					;does the file exist
	dos_int
	jc	not_there

	mov	ebx,eax					;close file
	mov	ah,3eh
	dos_int

	inc	[dn_u]
	cmp	[dn_u],'9'+1
	jc	try_file

	mov	[dn_u],'0'
	inc	[dn_t]
	cmp	[dn_t],'9'+1
	jc	try_file

	mov	[dn_t],'0'
	inc	[dn_h]
	jmp	try_file

not_there:	mov	ah,3ch					;create the file
	clear	ecx
	mov	edx,offset dump_name
	dos_int
	jc	dump_error

;	Write header

	mov	edx,offset lpf_data1
	mov	ecx,offset lpf_data1_end
	sub	ecx,edx
	mov	ebx,eax
	mov	ah,40h
	dos_int
	jc	dump_error

	mov	ecx,32		;record types
	mov	edx,[screen_copy]
	mov	ah,40h
	dos_int
	jc	dump_error

	mov	edx,offset lpf_data2
	mov	ecx,offset lpf_data2_end
	sub	ecx,edx
	mov	ah,40h
	dos_int
	jc	dump_error

	mov	ecx,58+128	;pad / cycles
	mov	edx,[screen_copy]
	mov	ah,40h
	dos_int
	jc	dump_error

;	Convert the palette

	mov	esi,[work_palette]
	mov	edi,[screen_copy]
	add	edi,20000
	push	edi
	mov	ecx,256
	clear	eax
con_col:	lodsb
	shl	ax,2
	mov	2[edi],al
	lodsb
	shl	ax,2
	mov	1[edi],al
	lodsb
	shl	ax,2
	mov	[edi],al
	lea	edi,4[edi]
	loop	con_col

	mov	ecx,1024
	pop	edx
	mov	ah,40h
	dos_int


	mov	edx,offset lpf_data3
	mov	ecx,offset lpf_data3_end
	sub	ecx,edx
	mov	ah,40h
	dos_int
	jc	dump_error

	mov	ecx,255*6		;lpf table
	mov	edx,[screen_copy]
	mov	ah,40h
	dos_int
	jc	dump_error

	mov	edx,offset lpf_data4
	mov	ecx,offset lpf_data4_end
	sub	ecx,edx
	mov	ah,40h
	dos_int
	jc	dump_error


;	copy screen

	mov	edi,[screen_copy]
	push	ds
	mov	ds,[screen_segment]
	clear	esi
	mov	ecx,64000/4
	rep	movsd
	pop	ds


;	Write data

	mov	ecx,16383
	mov	edx,offset data_16383
	call	write_block

	mov	ecx,16383
	mov	edx,offset data_16383
	call	write_block

	mov	ecx,16383
	mov	edx,offset data_16383
	call	write_block

	mov	ecx,14851
	mov	edx,offset data_14851
	call	write_block

	mov	ecx,3
	mov	edx,offset data_end
	mov	ah,40h
	dos_int

	mov	ah,3eh					;and close the file
	dos_int

dump_error:	mov	eax,[screen_copy]
	call	my_free
	
	ret

do_screen_dump	endp




write_block	proc

	push	ecx
	mov	ecx,3
	mov	ah,40h
	dos_int
	pop	ecx
	mov	edx,[screen_ptr]
	add	[screen_ptr],ecx
	mov	ah,40h
	dos_int
	ret

write_block	endp


end32code

	end
