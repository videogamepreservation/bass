include_macros	equ	1
include_deb_mac	equ	1
include_error_codes equ	1
	include include.asm



start32data
	align 4

game_grid	dd	?		;set bit 7 for re-create
				;set bit 0 for flip

end32data




start32code
	extrn	load_file:near
	extrn	my_free:near


re_create	proc

;	Check the game grid for blocks that have changed

	mov	eax,[layer_0_id]
	jife	eax,no_recreate
	fetch_item

	cherror esi,e,0,em_internal_error

	mov	edi,[backscreen]
	mov	ebx,[game_grid]

	mov	dh,GRID_Y

create_loop_y:	push	edi
	mov	dl,GRID_X

create_loop_x:	btr	wpt [ebx],7				;test and reset re-create flag
	jnc	not_block
	bts	wpt [ebx],0				;set for flip routine

	push	edi
	push	esi

	mov	eax,GRID_H
block_loop:	push	edi
	mov	ecx,GRID_W/4
	rep	movsd
	pop	edi
	add	edi,game_screen_width
	dec	eax
	jne	block_loop

	pop	esi
	pop	edi

not_block:	inc	ebx
	add	esi,GRID_W*GRID_H
	add	edi,GRID_W
	dec	dl
	jne	create_loop_x

	pop	edi
	add	edi,GRID_H*game_screen_width
	dec	dh
	jne	create_loop_y

no_recreate:	ret

re_create	endp


end32code

	end
