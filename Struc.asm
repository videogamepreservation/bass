


;	An item. Basically a sompact header

item_entry	struc

address	dd	?		;address of compact

item_entry	ends

;--------------------------------------------------------------------------------------------------

;	The header at the beginning of all data files

s	struc

flag	dw	?			;bit 0: set for colour data, clear for not
					;bit 1: set for compressed, clear for uncompressed
					;bit 2: set for 32 colours, clear for 16 colours
s_x	dw	?
s_y	dw	?
s_width	dw	?
s_height	dw	?
s_sp_size	dw	?
s_tot_size	dw	?
s_n_sprites	dw	?
s_offset_x	dw	?
s_offset_y	dw	?
s_compressed_size	dw	?

s	ends


;--------------------------------------------------------------------------------------------------

;	Here is the brand new all improved compact!!!

cpt	equ	compact ptr

compact	struc

c_logic	dw	?		;Entry in logic table to run	(byte as <256entries in logic table
c_status	dw	?
c_sync	dw	?		;flag sent to compacts by other things (what do you mean 'what?!'?)

c_screen	dw	?		;current screen
c_place	dw	?		;so's this one
c_get_to_table	dd	?		;Address of how to get to things table

c_xcood	dw	?
c_ycood	dw	?

c_frame	dw	?

c_cursor_text	dw	?
c_mouse_on	dw	?
c_mouse_off	dw	?
c_mouse_click	dw	?		;dword script

c_mouse_rel_x	dw	?
c_mouse_rel_y	dw	?
c_mouse_size_x	dw	?
c_mouse_size_y	dw	?

c_action_script	dw	?
c_up_flag	dw	?	;usually holds the Action Mode
c_down_flag	dw	?	;used for passing back
c_get_to_flag	dw	?	;used by action script for get to attempts, also frame store (hence word)
c_flag	dw	?	;a use any time flag

c_mood	dw	?	;high level - stood or not
c_grafix_prog	dd	?
c_offset	dw	?

c_mode	dw	?	;which mcode block

c_base_sub	dd	?	;1st mcode block relative to start of compact

c_action_sub	dd	?
c_get_to_sub	dw	?
	dw	?
c_extra_sub	dw	?
	dw	?

c_dir	dw	?

c_stop_script	dw	?
c_mini_bump	dw	?
c_leaving	dw	?
c_at_watch	dw	?			;pointer to script variable
c_at_was	dw	?			;pointer to script variable
c_alt	dw	?			;alternate script
c_request	dw	?

c_sp_width_xx	dw	?
c_sp_colour	dw	?
c_sp_text_id	dw	?
c_sp_time	dw	?

c_ar_anim_index	dw	?
c_turn_prog	dd	?

c_waiting_for	dw	?

c_ar_target_x	dw	?
c_ar_target_y	dw	?

c_anim_scratch	dd	?	;data area for AR



c_mega_set	dw	?

c_grid_width	dw	?
c_col_offset	dw	?
c_col_width	dw	?
c_last_chr	dw	?

c_anim_up	dd	?
c_anim_down	dd	?
c_anim_left	dd	?
c_anim_right	dd	?

c_stand_up	dd	?
c_stand_down	dd	?
c_stand_left	dd	?
c_stand_right	dd	?
c_stand_talk	dd	?

c_turn_table_up	dd	5 dup (?)	;up table
	dd	5 dup (?)	;down table
	dd	5 dup (?)	;left table
	dd	5 dup (?)	;right table
	dd	5 dup (?)	;talk table

compact	ends


;	Compact structure equates

;	status

st_background	equ	001h		;0 background sprite
st_foreground	equ	002h		;1 foreground
st_sort	equ	004h		;2 sort and print
st_recreate	equ	008h		;3 plot to recreate grid
st_mouse	equ	010h		;4 mouse detects
st_collision	equ	020h		;5 can collide
st_logic	equ	040h		;send through logic engine

st_grid_plot	equ	080h
st_ar_priority	equ	100h		;8 assign to player

st_no_vmask	equ	200h		;9 no vertical masking

st_collision_bit	equ	5


s_count	equ	0
s_frame	equ	2
s_ar_x	equ	4
s_ar_y	equ	6
s_length	equ	8

