include_macros	equ	1
include_deb_mac	equ	1
include_scripts	equ	1
include_files	equ	1
include_flags	equ	1
	include include.asm

	include script.asm


start32data

script_no	dw	?			;store for the script number

	align 4

script_compact	dd	?			;store for the current compact
module_start	dd	?			;address of the start of this module

int_stack	dd	20 dup (?)		;the interpreter stack

jump_table	dd	push_variable		;0
	dd	less_than		;1
	dd	push_number		;2
	dd	not_equal		;3
	dd	if_and			;4
	dd	skip_zero		;5
	dd	pop_var			;6
	dd	minus			;7
	dd	plus			;8
	dd	skip_always		;9
	dd	if_or			;10
	dd	call_mcode		;11
	dd	more_than		;12
	dd	script_exit		;13
	dd	switch			;14
	dd	push_offset		;15
	dd	pop_offset		;16
	dd	is_equal			;17
	dd	skip_nz			;18
	dd	script_exit		;19 Not really needed
	dd	restart_script

module_list	dd	16 dup (0)


forward1b_lab	equ	jobsworth_speech
no_forwards1b	equ	63

forward_list1b	dd	jobs_speech
	dd	jobs_s4
	dd	jobs_alarmed
	dd	joey_recycle
	dd	shout_sss
	dd	joey_mission
	dd	trans_mission
	dd	slot_mission
	dd	corner_mission
	dd	joey_logic
	dd	gordon_speech
	dd	joey_button_mission
	dd	lob_dad_speech
	dd	lob_son_speech
	dd	guard_speech
	dd	mantrach_speech
	dd	wreck_speech
	dd	anita_speech
	dd	lamb_factory
	dd	fore_speech
	dd	joey_42_miss
	dd	joey_junction_miss
	dd	welder_mission
	dd	joey_weld_mission
	dd	radman_speech
	dd	link_7_29
	dd	link_29_7
	dd	lamb_to_3
	dd	lamb_to_2
	dd	burke_speech
	dd	burke_1
	dd	burke_2
	dd	dr_burke_1
	dd	jason_speech
	dd	joey_bellevue
	dd	anchor_speech
	dd	anchor_mission
	dd	joey_pc_mission
	dd	hook_mission
	dd	trevor_speech
	dd	joey_factory
	dd	helga_speech
	dd	joey_helga_mission
	dd	gall_bellevue
	dd	glass_mission
	dd	lamb_fact_return
	dd	lamb_leave_garden
	dd	lamb_start_29
	dd	lamb_bellevue
	dd	cable_mission
	dd	foster_tour
	dd	lamb_tour
	dd	foreman_logic
	dd	lamb_leave_factory
	dd	lamb_bell_logic
	dd	lamb_fact_2
	dd	start90
	dd	0
	dd	0
	dd	link_28_31
	dd	link_31_28
	dd	exit_linc
	dd	death_script


forward2b_lab	equ	ref_std_on
no_forwards2b	equ	7

forward_list2b	dd	std_on
	dd	std_exit_left_on
	dd	std_exit_right_on
	dd	advisor_188
	dd	shout_action
	dd	mega_click
	dd	mega_action

forward3b_lab	equ	ref_danielle_speech
no_forwards3b	equ	21

forward_list3b	dd	dani_speech
	dd	danielle_go_home
	dd	spunky_go_home
	dd	henri_speech
	dd	buzzer_speech
	dd	foster_visit_dani
	dd	danielle_logic
	dd	jukebox_speech
	dd	vincent_speech
	dd	eddie_speech
	dd	blunt_speech
	dd	dani_answer_phone
	dd	spunky_see_video
	dd	spunky_bark_at_foster
	dd	spunky_smells_food
	dd	barry_speech
	dd	colston_speech
	dd	gall_speech
	dd	babs_speech
	dd	chutney_speech
	dd	foster_enter_court


forward4b_lab	equ	ref_walter_speech
no_forwards4b	equ	14

forward_list4b	dd	walter_speech
	dd	joey_medic
	dd	joey_med_logic
	dd	joey_med_mission72
	dd	ken_logic
	dd	ken_speech
	dd	ken_mission_hand
	dd	sc70_iris_opened
	dd	sc70_iris_closed
	dd	foster_enter_boardroom
	dd	bored_room
	dd	foster_enter_new_boardroom
	dd	hobs_end
	dd	sc82_jobs_sss


forward5b_lab	equ	start_info_window
no_forwards5b	equ	7

forward_list5b	dd	set_up_info_window
	dd	slab_on
	dd	up_mouse
	dd	down_mouse
	dd	left_mouse
	dd	right_mouse
	dd	disconnect_foster


end32data


start32code
	extrn	load_file:near

init_script	proc

	mov	esi,offset forward_list1b
	mov	edi,offset forward1b_lab
	mov	ecx,no_forwards1b
	rep	movsd

	mov	esi,offset forward_list2b
	mov	edi,offset forward2b_lab
	mov	ecx,no_forwards2b
	rep	movsd

	mov	esi,offset forward_list3b
	mov	edi,offset forward3b_lab
	mov	ecx,no_forwards3b
	rep	movsd

	mov	esi,offset forward_list4b
	mov	edi,offset forward4b_lab
	mov	ecx,no_forwards4b
	rep	movsd

	mov	esi,offset forward_list5b
	mov	edi,offset forward5b_lab
	mov	ecx,no_forwards5b
	rep	movsd

	ret

init_script	endp




check_module_loaded	proc


;	Make sure module eax is loaded

	mov	ebx,[offset module_list + eax*4]	;already in?
	jifne	ebx,mod_in

	push	eax				;load it
	add	eax,f_module_0
	clear	edx
	call	load_file
	pop	ebx
	mov	[offset module_list + ebx*4],eax

mod_in:	ret

check_module_loaded	endp




script	proc

;	process a script
;	low level interface to interpreter

;	eax defines the script.
;	Bit  0-11 - Script number
;	Bit 12-15 - Module number
;	Bit 16-31 - Script offset (if any)

;	esi holds mega compact if relevant

ifdef debug_42
	bt	[_debug_flag],df_script
	jnc	no_debug
	printf "Doing Script %x",eax
	debug_compact esi,"Into Script"
no_debug:
endif
	mov	[script_no],ax
	mov	[script_compact],esi

	movzx	ebx,ah
	and	ah,0fh
	shr	ebx,2
	mov	esi,module_list[ebx]			;get module address
	jifne	esi,module_present

;	The module has not been loaded: What do we do?

	push	eax
	push	ebx

	shr	ebx,2					;get module number
	add	ebx,f_module_0				;and get module file
	mov	eax,ebx
	clear	edx					;allocate memory for this module
	call	load_file

	mov	esi,eax					;module address
	pop	ebx
	mov	module_list[ebx],esi			;module has been loaded
	pop	eax

module_present:	mov	[module_start],esi

	cherror ax,a,[esi],em_internal_error

;	Check whether we have an offset or what

	test	eax,0ffff0000h
	jne	got_offset

	shl	eax,1					;turn number into pointer
	mov	ax,[eax+esi]				;get new offset
	shl	ax,1
	add	esi,eax					;and go
	jmp	interpreter

got_offset:	shr	eax,15					;get offset
	add	eax,[module_start]			;point into module data
	mov	esi,eax

interpreter:	;Go do that script

;	esi is pointer to script data

	mov	edi,offset int_stack

;	And now interpret.....

inter_loop:	movzx	eax,wpt[esi]				;get a command
	inc	esi
	inc	esi
	jmp	jump_table[eax*4]


;	Skip if non zero

skip_nz::	flodswl eax,esi

	sub	edi,4
	test	dpt [edi],-1
	je	inter_loop

	cwde
	add	esi,eax
	jmp	inter_loop


;	Skip if zero

skip_zero::	flodswl eax,esi

	sub	di,4
	test	dpt [edi],-1
	jne	inter_loop

	add	esi,eax
	jmp	inter_loop


;	Push a variable on to the stack

push_variable::	flodswl eax,esi				;get variable number
	mov	eax,[offset script_variables+eax]	;get variable contents
	stosd					;and put them on the stack
	jmp	inter_loop


;	if (di-2) < (di-4) leave 1 on the stack, else leave 0

less_than::	mov	eax,[edi-8]
	cmp	eax,[edi-4]
	jc	leave_1

leave_0::	sub	edi,4
	mov	dpt [edi-4],0
	jmp	inter_loop

leave_1::	sub	edi,4
	mov	dpt [edi-4],1
	jmp	inter_loop


;	if (di-2) != (di-4) leave 1 on the stack, else leave 0

not_equal::	mov	eax,[edi-4]
	cmp	eax,[edi-8]
	jne	leave_1
	jmp	leave_0


;	Non logical and (=1 if both non zero)

if_and::	test	dpt [edi-4],-1
	je	leave_0

	test	dpt [edi-8],-1
	je	leave_0

	jmp	leave_1

;	if (di-8) > (di-4) leave 1 on the stack, else leave 0

more_than::	mov	eax,[edi-4]
	cmp	eax,[edi-8]

;	If (-8) > (-4) then carry should be set. Changed from "jna leave_0"

	jc	leave_1
	jmp	leave_0


;	If (a2) == (a2+2) leave 1 on the stack, else leave 0

is_equal::	mov	eax,[edi-4]
	cmp	eax,[edi-8]
	je	leave_1
	jmp	leave_0


;	Non logical or (=1 if either non zero)

if_or::	test	dpt [edi-4],-1
	jne	leave_1

	test	dpt [edi-8],-1
	jne	leave_1

	jmp	leave_0

;	Push a number on to the stack

push_number::	flodswl eax,esi
	stosd
	jmp	inter_loop



;	Pop a value into a variable

pop_var::	flodswl eax,esi

	sub	edi,4
	mov	ebx,[edi]
	mov	[offset script_variables+eax],ebx
	jmp	inter_loop


;	Subtract two numbers

minus::	sub	edi,4
	mov	eax,[edi]
	sub	[edi-4],eax
	jmp	inter_loop


;	Add two numbers

plus::	sub	edi,4
	mov	eax,[edi]
	add	[edi-4],eax
	jmp	inter_loop


skip_always::	flodswl eax,esi
	add	esi,eax
	jmp	inter_loop


;	Call an mcode routine


call_mcode::	flodswl eax,esi			;get number of parameters
	cmp	ax,1
	jc	param_0
	je	param_1
	cmp	ax,3
	jc	param_2


param_3:	sub	edi,4
	mov	ecx,[edi]

param_2:	sub	edi,4
	mov	ebx,[edi]

param_1:	sub	edi,4
	mov	eax,[edi]
	
param_0:	movzx	edx,wpt[esi]		;get mcode number
	add	esi,2

;	Save what we need from possible recalls of the interpreter

	push	edi			;save the stack pointer
	push	esi

	mov	di,[script_no]		;use edi so script no sneaks thru to fn_routine (debug only)
	push	edi

	mov	esi,[module_start]
	push	esi

	mov	esi,[script_compact]
	push	esi

	call	mcode_table[edx]

	pop	esi
	mov	[script_compact],esi

	pop	esi
	mov	[module_start],esi

	pop	esi
	mov	[script_no],si

	pop	esi
	pop	edi

;	The mcode returns 0 for halt script at this point, non zero for continue

	and	eax,0ffffh		;strip top bits anyway
	jne	inter_loop

;	We want to leave the interpreter with the current script location

;	esi is instriction counter

script_halt:	mov	eax,esi
	sub	eax,[module_start]	;get offset into script
	shl	eax,15			;and whisk it away
	mov	ax,[script_no]		;get script number back
	mov	esi,[script_compact]

	ret				;and return



;	This script has finished

script_exit::	movzx	eax,[script_no]
	mov	esi,[script_compact]
	ret					;Shirley there must be more to it than this


restart_script::	;restart the current script

	movzx	eax,[script_no]
	mov	esi,[script_compact]
	jmp	script
	


switch::	movzx	ecx,wpt[esi]			;get number of cases
	add	esi,2

	sub	edi,4				;and value to switch on
	mov	eax,[edi]

sw_loop:	cmp	ax,[esi]
	je	got_value

	add	esi,4
	floop	sw_loop

	flodswl eax,esi
	add	esi,eax				;use the default
	sub	esi,2
	jmp	inter_loop

got_value:	mov	ax,[esi+2]			;move on to case
	add	esi,eax
	add	esi,2
	jmp	inter_loop



;	Push a compact access

push_offset::	flodswl eax,esi				;get offset
	add	eax,[script_compact]
	movzx	eax,wpt[eax]			;assume all words
	stosd
	jmp	inter_loop


;	pop a value into a compact

pop_offset::	flodswl eax,esi				;get offset
	add	eax,[script_compact]
	sub	edi,4
	mov	bx,[edi]				;get value
	mov	[eax],bx
	jmp	inter_loop

script	endp


end32code

	end
