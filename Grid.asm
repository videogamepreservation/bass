include_macros	equ	1
include_struc	equ	1
include_deb_mac	equ	1
include_error_codes equ	1
	include include.asm


grid_file_start	equ	60000			;number of first grid file

start32data

game_grids	dd	?			;pointer to game grid data


grid_convert_table	db	0	;0
	db	1	;1
	db	2	;2
	db	3	;3
	db	4	;4
	db	5	;5
	db	6	;6
	db	7	;7
	db	8	;8
	db	9	;9
	db	10	;10
	db	11	;11
	db	12	;12
	db	13	;13
	db	14	;14
	db	15	;15
	db	16	;16
	db	17	;17
	db	18	;18
	db	19	;19
	db	20	;20
	db	21	;21
	db	22	;22
	db	23	;23
	db	24	;24
	db	25	;25
	db	26	;26
	db	27	;27
	db	28	;28
	db	29	;29
	db	30	;30
	db	31	;31
	db	32	;32
	db	33	;33
	db	34	;34
	db	-1	;35
	db	35	;36
	db	36	;37
	db	37	;38
	db	38	;39
	db	39	;40
	db	40	;41
	db	41	;42
	db	-1	;43
	db	42	;44
	db	43	;45
	db	44	;46
	db	45	;47
	db	46	;48
	db	-1	;49
	db	-1	;50
	db	-1	;51
	db	-1	;52
	db	-1	;53
	db	-1	;54
	db	-1	;55
	db	-1	;56
	db	-1	;57
	db	-1	;58
	db	-1	;59
	db	-1	;60
	db	-1	;61
	db	-1	;62
	db	-1	;63
	db	-1	;64
	db	47	;65
	db	tot_no_grids	;66
	db	48	;67
	db	49	;68
	db	50	;69
	db	51	;70
	db	52	;71
	db	53	;72
	db	54	;73
	db	55	;74
	db	56	;75
	db	57	;76
	db	58	;77
	db	59	;78
	db	60	;79
	db	-1	;80
	db	61	;81
	db	62	;82
	db	-1	;83
	db	-1	;84
	db	-1	;85
	db	-1	;86
	db	-1	;87
	db	-1	;88
	db	tot_no_grids	;89
	db	63	;90
	db	64	;91
	db	65	;92
	db	66	;93
	db	67	;94
	db	68	;95
	db	69	;96


end32data




start32code
	extrn	my_malloc:near
	extrn	load_file:near

initialise_grids	proc

	mov	eax,tot_no_grids*grid_size
	call	my_malloc
	mov	[game_grids],eax

	ret

initialise_grids	endp




load_grids	proc

	mov	eax,grid_file_start
	mov	ecx,tot_no_grids
	mov	edx,[game_grids]

grid_loop:	push	eax
	push	ecx
	push	edx
	call	load_file
	pop	edx
	add	edx,grid_size
	pop	ecx
	pop	eax
	inc	eax
	floop	grid_loop

ifndef s1_demo	;single disk demos never get that far

;	Reloading the grids can sometimes cause problems
;	eg when reichs door is open the door grid bit gets replaced so you can't get back in (or out)

	test	[reich_door_flag],-1
	je	reich_closed

	mov	esi,offset reich_door_20
	mov	eax,256
	mov	ebx,280
	mov	ecx,1
	call	fn_remove_grid
endif

reich_closed:

	ret

load_grids	endp




remove_object_from_walk	proc

	call	get_grid_values
	je	no_walk

fn_remove_object_from_walk::

otw_loop:	btr	[ebx],ecx
	dec	ecx
	jns	novf
	add	ebx,4
	mov	ecx,1fh
novf:	floop	edx,otw_loop

no_walk:	mov	al,1					;don't quit from interpreter
	ret

remove_object_from_walk endp




object_to_walk	proc

	call	get_grid_values
	je	no_walk

fn_object_to_walk::

otw_loop:	bts	[ebx],ecx
	dec	ecx
	jns	novf
	add	ebx,4
	mov	ecx,1fh
novf:	floop	edx,otw_loop

no_walk:	mov	al,1					;don't quit from interpreter
	ret

object_to_walk	endp




get_grid_values	proc

;	esi is object compact

	movzx	ebx,(cpt[esi]).c_ycood			;get y coordinate
	movzx	ecx,(cpt[esi]).c_xcood

	movzx	edx,(cpt[esi]).c_mega_set			;get correct set
	movzx	edx,wpt c_grid_width[esi+edx]		;get block width

fn_get_grid_values::
;	ebx = y
;	ecx = x
;	edx = width-1

	sub	ebx,top_left_y
	jc	off_screen
	shr	ebx,3					;turn into blocks
	cmp	ebx,GRID_Y
	jnc	off_screen

	imul	ebx,ebx,40				;turn into bits

;	Look at x coordinate

	shr	ecx,3					;turn into blocks

	inc	edx					;Value is offset for 68000 dbf

	sub	ecx,top_left_x/8				;remove left value
	jnc	x_ok
	add	edx,ecx					;adjust width
	jnc	off_screen
	je	off_screen

x_ok:	;x is ok on left. Check right

	mov	eax,game_screen_width/8
	sub	eax,ecx
	jbe	off_screen

	sub	eax,edx
	jnc	x2_ok
	add	edx,eax
	jnc	off_screen
	je	off_screen

x2_ok:	add	ecx,ebx					;bit position of start

	mov	ebx,ecx					;get dword offset
	and	ebx,0ffffffe0h
	shr	ebx,3					;bits to bytes
	add	ebx,[game_grids]

	movzx	eax,(cpt[esi]).c_screen			;get correct screen
	mov	al,bpt[offset grid_convert_table+eax]
	cherror al,nc,tot_no_grids+1,em_internal_error

	imul	eax,eax,grid_size
	add	ebx,eax

	and	ecx,01fh					;bit number
	sub	ecx,01fh
	neg	ecx
	or	al,1					;clear z flag
	ret

off_screen:	clear	eax
	ret

get_grid_values	endp


end32code

	end
