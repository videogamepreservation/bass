start32save_data



window_1	dw	l_script
	dw	st_logic+st_foreground+st_recreate
	dw	NULL
	dw	90
	dw	NULL
	dd	NULL
	dw	195
	dw	160
	dw	s26
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dd	NULL
	dw	NULL
	dw	c_base_mode
	dw	info_window_logic
	dw	0


window_2	dw	l_script
	dw	st_logic+st_foreground+st_recreate
	dw	NULL
	dw	90
	dw	NULL
	dd	NULL
	dw	195+76
	dw	160
	dw	1+s26
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dd	NULL
	dw	NULL
	dw	c_base_mode
	dw	info_window_logic
	dw	0


window_3	dw	l_script
	dw	st_logic+st_foreground+st_recreate
	dw	NULL
	dw	90
	dw	NULL
	dd	NULL
	dw	195
	dw	160+72
	dw	2+s26
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dd	NULL
	dw	NULL
	dw	c_base_mode
	dw	info_window_logic
	dw	0


window_4	dw	l_script
	dw	st_logic+st_foreground+st_recreate
	dw	NULL
	dw	90
	dw	NULL
	dd	NULL
	dw	195+76
	dw	160+72
	dw	3+s26
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dd	NULL
	dw	NULL
	dw	c_base_mode
	dw	info_window_logic
	dw	0


info_button	dw	l_script
	dw	st_logic+st_mouse+st_foreground+st_recreate
	dw	NULL
	dw	90
	dw	NULL
	dd	NULL
	dw	334
	dw	285
	dw	s137
	dw	NULL
	dw	button_mouse
	dw	normal_mouse
	dw	close_window
	dw	2
	dw	1
	dw	37
	dw	9
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dd	NULL
	dw	NULL
	dw	c_base_mode
	dw	info_button_logic
	dw	0



end32save_data

start32data



grid90	dd 0 dup (0)

grid91	dd 0 dup (0)

grid92	dd 0 dup (0)

grid93	dd 0 dup (0)

grid94	dd 0 dup (0)

grid95	dd 0 dup (0)

grid96	dd 0 dup (0)

head_module	dw	11
	dw	176
	dw	0
	dw	199
	dw	161


file_module	dw	11
	dw	176
	dw	0
	dw	199
	dw	178


size_module	dw	11
	dw	176
	dw	0
	dw	199
	dw	190


auth_module	dw	11
	dw	176
	dw	0
	dw	199
	dw	202


note_module	dw	11
	dw	176
	dw	0
	dw	199
	dw	226


rs_foster_s90	dw	c_screen
	dw	90
	dw	c_place
	dw	id_sc90_floor
	dw	c_xcood
	dw	288
	dw	c_ycood
	dw	280
	dw	c_dir
	dw	down
	dw	c_frame
	dw	s117
	dw	-1


crouch_left	dw	s16
	dw	320
	dw	215
	dw	0
	dw	320
	dw	215
	dw	1
	dw	320
	dw	215
	dw	2
	dw	320
	dw	215
	dw	3
	dw	320
	dw	215
	dw	3
	dw	320
	dw	215
	dw	3
	dw	320
	dw	215
	dw	3
	dw	320
	dw	215
	dw	2
	dw	320
	dw	215
	dw	1
	dw	320
	dw	215
	dw	0
	dw	0


crouch_right	dw	s17
	dw	260
	dw	215
	dw	0
	dw	260
	dw	215
	dw	1
	dw	260
	dw	215
	dw	2
	dw	260
	dw	215
	dw	3
	dw	260
	dw	215
	dw	3
	dw	260
	dw	215
	dw	3
	dw	260
	dw	215
	dw	3
	dw	260
	dw	215
	dw	2
	dw	260
	dw	215
	dw	1
	dw	260
	dw	215
	dw	0
	dw	0


crouch_right_a	dw	s17
	dw	1
	dw	1
	dw	0
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	3
	dw	1
	dw	1
	dw	3
	dw	0


crouch_right_b	dw	s17
	dw	1
	dw	1
	dw	3
	dw	1
	dw	1
	dw	3
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	0
	dw	0


crouch_down	dw	s20
	dw	201
	dw	272
	dw	0
	dw	201
	dw	272
	dw	1
	dw	201
	dw	272
	dw	2
	dw	201
	dw	272
	dw	3
	dw	201
	dw	272
	dw	3
	dw	201
	dw	272
	dw	3
	dw	201
	dw	272
	dw	3
	dw	201
	dw	272
	dw	2
	dw	201
	dw	272
	dw	1
	dw	201
	dw	272
	dw	0
	dw	0


shrug	dw	s182
	dw	1
	dw	1
	dw	48
	dw	1
	dw	1
	dw	49
	dw	1
	dw	1
	dw	49
	dw	1
	dw	1
	dw	49
	dw	1
	dw	1
	dw	49
	dw	1
	dw	1
	dw	48
	dw	0


enter_top	dw	s135
	dw	200
	dw	215
	dw	0
	dw	200
	dw	215
	dw	1
	dw	200
	dw	215
	dw	2
	dw	200
	dw	215
	dw	3
	dw	200
	dw	215
	dw	4
	dw	200
	dw	215
	dw	5
	dw	200
	dw	215
	dw	6
	dw	0


exit_top	dw	s136
	dw	200
	dw	215
	dw	0
	dw	200
	dw	215
	dw	1
	dw	200
	dw	215
	dw	2
	dw	200
	dw	215
	dw	3
	dw	200
	dw	215
	dw	4
	dw	200
	dw	215
	dw	5
	dw	200
	dw	215
	dw	6
	dw	0


logon	dw	s117
	dw	1
	dw	1
	dw	8
	dw	1
	dw	1
	dw	7
	dw	1
	dw	1
	dw	6
	dw	1
	dw	1
	dw	5
	dw	1
	dw	1
	dw	4
	dw	1
	dw	1
	dw	3
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	0
	dw	0


logoff	dw	s117
	dw	261
	dw	181
	dw	0
	dw	261
	dw	181
	dw	1
	dw	261
	dw	181
	dw	2
	dw	261
	dw	181
	dw	1
	dw	261
	dw	181
	dw	3
	dw	261
	dw	181
	dw	4
	dw	261
	dw	181
	dw	5
	dw	261
	dw	181
	dw	6
	dw	261
	dw	181
	dw	7
	dw	261
	dw	181
	dw	8
	dw	0


window_logic	dw	id_window_1
	dw	id_window_2
	dw	id_window_3
	dw	id_window_4
	dw	id_info_button
	dw	23
	dw	24
	dw	25
	dw	26
	dw	27
	dw	28
	dw	29
	dw	30
	dw	31
	dw	32
	dw	0


window_mouse	dw	id_info_button
	dw	0



end32data

start32save_data



end32save_data
