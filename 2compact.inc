start32data



fast_list_sc2	dw	12
	dw	51
	dw	52
	dw	53
	dw	54
	dw	135+$8000
	dw	153+$8000
	dw	200+$8000
	dw	174
	dw	201+$8000
	dw	112
	dw	113
	dw	114
	dw	163
	dw	164
	dw	165
	dw	149
	dw	0


chip_list_s2	dw	148
	dw	155
	dw	156+$000
	dw	157+$000
	dw	160
	dw	166+$8000
	dw	173
	dw	111
	dw	117
	dw	134
	dw	150
	dw	227
	dw	0


sc2_logic	dw	id_foster
	dw	id_joey
	dw	jobs
	dw	id_cupboard
	dw	id_knob
	dw	id_lazer
	dw	id_top_lift
	dw	4344
	dw	id_top_barrel
	dw	id_loader
	dw	id_upload
	dw	id_dead_loader
	dw	id_light1
	dw	id_panel
	dw	id_alarm
	dw	id_robot_shell
	dw	id_press
	dw	$ffff
	dw	id_menu_logic


sc2_mouse	dw	jobs
	dw	id_loader
	dw	id_dead_loader
	dw	id_joey
	dw	id_robot_shell
	dw	id_junk1
	dw	id_junk2
	dw	id_light1
	dw	id_panel
	dw	id_top_lift
	dw	id_hole
	dw	115
	dw	id_l_exit_s2
	dw	id_r_exit_s2
	dw	$ffff
	dw	id_text_mouse


right_exit_rm2	dw	0
	dw	st_mouse
	dw	0
	dw	2
	dw	NULL
	dd	0
	dw	388
	dw	185
	dw	0
	dw	1+t7
	dw	std_exit_right_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	11
	dw	71
	dw	er2_action



end32data

start32save_data



top_lift	dw	l_script
	dw	st_background+st_logic+st_recreate+st_mouse
	dw	0
	dw	2
	dw	NULL
	dd	top_lift_table
	dw	244
	dw	250
	dw	s148
	dw	19+t7
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	48
	dw	21
	dw	top_lift_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	top_lift_logic
	dw	0



end32save_data

start32data



top_lift_table	dw	id_top_lift
	dw	return_ok
	dw	115
	dw	lift_to_floor
	dw	id_l_exit_s2
	dw	lift_to_floor
	dw	id_r_exit_s2
	dw	lift_to_floor
	dw	21
	dw	lift_to_floor
	dw	22
	dw	lift_to_floor
	dw	id_hole
	dw	lift_to_floor
	dw	id_dead_loader
	dw	get_to_transporter
	dw	id_robot_shell
	dw	get_to_shell
	dw	id_panel
	dw	GT_panel2
	dw	id_junk1
	dw	GT_junk1
	dw	id_junk2
	dw	GT_junk2
	dw	-1


top_lift_down	dw	s148
	dw	244
	dw	250
	dw	0
	dw	244
	dw	250
	dw	1
	dw	244
	dw	250
	dw	2
	dw	244
	dw	250
	dw	3
	dw	244
	dw	250
	dw	4
	dw	244
	dw	250
	dw	5
	dw	244
	dw	250
	dw	6
	dw	0


top_lift_up	dw	s148
	dw	244
	dw	250
	dw	6
	dw	244
	dw	250
	dw	5
	dw	244
	dw	250
	dw	4
	dw	244
	dw	250
	dw	3
	dw	244
	dw	250
	dw	2
	dw	244
	dw	250
	dw	1
	dw	244
	dw	250
	dw	0
	dw	0
	dw	0



end32data

start32save_data



top_lift_2	dw	l_script
	dw	st_sort+st_logic+st_recreate
	dw	0
	dw	2
	dw	NULL
	dd	0
	dw	284
	dw	196
	dw	s149
	dw	19+t7
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	top_lift_2_logic
	dw	0



end32save_data

start32data



top_lift_2_down	dw	s149
	dw	284
	dw	196
	dw	0
	dw	284
	dw	196
	dw	1
	dw	284
	dw	196
	dw	2
	dw	284
	dw	196
	dw	3
	dw	284
	dw	196
	dw	4
	dw	284
	dw	196
	dw	5
	dw	284
	dw	196
	dw	6
	dw	284
	dw	196
	dw	7
	dw	284
	dw	196
	dw	8
	dw	284
	dw	196
	dw	9
	dw	284
	dw	196
	dw	10
	dw	284
	dw	196
	dw	11
	dw	284
	dw	196
	dw	12
	dw	284
	dw	196
	dw	13
	dw	284
	dw	196
	dw	14
	dw	284
	dw	196
	dw	15
	dw	284
	dw	196
	dw	16
	dw	284
	dw	196
	dw	17
	dw	0


top_lift_2_up	dw	s149
	dw	284
	dw	196
	dw	17
	dw	284
	dw	196
	dw	16
	dw	284
	dw	196
	dw	15
	dw	284
	dw	196
	dw	14
	dw	284
	dw	196
	dw	13
	dw	284
	dw	196
	dw	12
	dw	284
	dw	196
	dw	11
	dw	284
	dw	196
	dw	10
	dw	284
	dw	196
	dw	9
	dw	284
	dw	196
	dw	8
	dw	284
	dw	196
	dw	7
	dw	284
	dw	196
	dw	6
	dw	284
	dw	196
	dw	5
	dw	284
	dw	196
	dw	4
	dw	284
	dw	196
	dw	3
	dw	284
	dw	196
	dw	2
	dw	284
	dw	196
	dw	1
	dw	284
	dw	196
	dw	0
	dw	0
	dw	0


hole	dw	0
	dw	st_mouse
	dw	0
	dw	2
	dw	NULL
	dd	NULL
	dw	247
	dw	252
	dw	NULL
	dw	20+t7
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	45
	dw	19
	dw	hole_action



end32data

start32save_data



top_barrel	dw	l_script
	dw	0
	dw	0
	dw	2
	dw	NULL
	dd	NULL
	dw	262
	dw	240
	dw	s155
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	top_barrel_logic
	dw	0


light_one	dw	l_script
	dw	st_background+st_logic+st_mouse
	dw	0
	dw	2
	dw	NULL
	dd	NULL
	dw	216
	dw	188
	dw	s163
	dw	4186
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	12
	dw	8
	dw	light1_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	light_logic
	dw	0


panel	dw	l_script
	dw	st_background+st_logic+st_mouse
	dw	0
	dw	2
	dw	NULL
	dd	NULL
	dw	321
	dw	187
	dw	s165
	dw	4186
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	12
	dw	12
	dw	panel2_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	panel_logic
	dw	0


alarm_flash	dw	l_script
	dw	0
	dw	0
	dw	2
	dw	NULL
	dd	NULL
	dw	0
	dw	0
	dw	0
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	alarm_logic
	dw	0


robot_shell	dw	l_script
	dw	st_foreground+st_mouse+st_recreate+st_logic
	dw	0
	dw	2
	dw	NULL
	dd	NULL
	dw	312
	dw	294
	dw	s174
	dw	4546
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	16
	dw	16
	dw	shell_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	joey_start
	dw	0


dead_loader	dw	l_script
	dw	st_sort+st_recreate+st_logic+st_mouse
	dw	0
	dw	2
	dw	115
	dd	transporter_table
	dw	$d2
	dw	$f0
	dw	s156+6
	dw	4426
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	-4
	dw	-48
	dw	20
	dw	48
	dw	transporter_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	0
	dw	dead_logic
	dw	0



end32save_data

start32data



transporter_table	dw	115
	dw	std_adjoin_floor
	dw	id_l_exit_s2
	dw	get_to_el2
	dw	id_r_exit_s2
	dw	get_to_er2
	dw	id_top_lift
	dw	get_to_lifter
	dw	21
	dw	get_to_talk21
	dw	22
	dw	get_to_talk22
	dw	id_light1
	dw	get_to_light1
	dw	id_hole
	dw	get_to_hole
	dw	id_dead_loader
	dw	get_to_transporter
	dw	id_robot_shell
	dw	get_to_shell
	dw	id_panel
	dw	GT_panel2
	dw	id_junk1
	dw	GT_junk1
	dw	id_junk2
	dw	GT_junk2
	dw	-1


joey_list_s2	dw	168
	dw	368
	dw	232
	dw	288
	dw	1
	dw	192
	dw	336
	dw	248
	dw	272
	dw	0
	dw	216
	dw	312
	dw	232
	dw	248
	dw	0
	dw	0


left_exit_rm2	dw	0
	dw	st_mouse
	dw	0
	dw	2
	dw	NULL
	dd	left_table2
	dw	128
	dw	164
	dw	0
	dw	1+t7
	dw	std_exit_left_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	20
	dw	150
	dw	el2_action



end32data

start32save_data



exit_table	dd 0 dup (0)

left_table2	dd 0 dup (0)

junk1	dw	0
	dw	st_mouse
	dw	0
	dw	2
	dw	NULL
	dd	NULL
	dw	276
	dw	293
	dw	null
	dw	4546
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	306-276
	dw	309-293
	dw	junk1_action


junk2	dw	0
	dw	st_mouse
	dw	0
	dw	2
	dw	NULL
	dd	NULL
	dw	332
	dw	289
	dw	null
	dw	4546
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	355-332
	dw	315-289
	dw	junk2_action


c4121	dd 0 dup (0)

loader	dw	1
	dw	0
	dw	0
	dw	2
	dw	115
	dd	NULL
	dw	$d2
	dw	$f0
	dw	s156+6
	dw	4426
	dw	std_on
	dw	std_off
	dw	mega_click
	dw	-4
	dw	-48
	dw	20
	dw	48
	dw	trans_alive_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	0
	dw	loader_start
	dw	0
	dd	0
	dd	0
	dd	0
	dw	2
	dw	std_mega_stop
	dw	std_mini_bump
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	96
	dw	sp_col_loader
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	0
	dw	0
	dd	loader_auto
	dw	0*next_mega_set
	dw	3
	dw	8
	dw	16
	dw	24
	dd	loader_up
	dd	loader_down
	dd	loader_left
	dd	loader_right
	dd	loader_st_up
	dd	loader_st_down
	dd	loader_st_left
	dd	loader_st_right
	dd	0
	dd	0
	dd	loader_u_to_d
	dd	loader_u_to_l
	dd	loader_u_to_r
	dd	0
	dd	loader_d_to_u
	dd	0
	dd	loader_d_to_l
	dd	loader_d_to_r
	dd	0
	dd	loader_l_to_u
	dd	loader_l_to_d
	dd	0
	dd	loader_l_to_r
	dd	0
	dd	loader_r_to_u
	dd	loader_r_to_d
	dd	loader_r_to_l
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dw	3
	dw	8
	dw	16
	dw	24
	dd	loaderb_up
	dd	loaderb_down
	dd	loaderb_left
	dd	loaderb_right
	dd	loaderb_st_up
	dd	loaderb_st_down
	dd	loaderb_st_left
	dd	loaderb_st_right
	dd	0
	dd	0
	dd	loaderb_u_to_d
	dd	loaderb_u_to_l
	dd	loaderb_u_to_r
	dd	0
	dd	loaderb_d_to_u
	dd	0
	dd	loaderb_d_to_l
	dd	loaderb_d_to_r
	dd	0
	dd	loaderb_l_to_u
	dd	loaderb_l_to_d
	dd	0
	dd	loaderb_l_to_r
	dd	0
	dd	loaderb_r_to_u
	dd	loaderb_r_to_d
	dd	loaderb_r_to_l
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dw	0
	dw	0
	dw	8
	dw	8
	dd	sml_loader_up
	dd	sml_loader_down
	dd	sml_loader_left
	dd	sml_loader_right
	dd	sml_loader_st_up
	dd	sml_loader_st_down
	dd	sml_loader_st_left
	dd	sml_loader_st_right
	dd	0
	dd	0
	dd	sml_loader_u_to_d
	dd	sml_loader_u_to_l
	dd	sml_loader_u_to_r
	dd	0
	dd	sml_loader_d_to_u
	dd	0
	dd	sml_loader_d_to_l
	dd	sml_loader_d_to_r
	dd	0
	dd	sml_loader_l_to_u
	dd	sml_loader_l_to_d
	dd	0
	dd	sml_loader_l_to_r
	dd	0
	dd	sml_loader_r_to_u
	dd	sml_loader_r_to_d
	dd	sml_loader_r_to_l
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dw	0
	dw	0
	dw	8
	dw	8
	dd	sml_loaderb_up
	dd	sml_loaderb_down
	dd	sml_loaderb_left
	dd	sml_loaderb_right
	dd	sml_loaderb_st_up
	dd	sml_loaderb_st_down
	dd	sml_loaderb_st_left
	dd	sml_loaderb_st_right
	dd	0
	dd	0
	dd	sml_loaderb_u_to_d
	dd	sml_loaderb_u_to_l
	dd	sml_loaderb_u_to_r
	dd	0
	dd	sml_loaderb_d_to_u
	dd	0
	dd	sml_loaderb_d_to_l
	dd	sml_loaderb_d_to_r
	dd	0
	dd	sml_loaderb_l_to_u
	dd	sml_loaderb_l_to_d
	dd	0
	dd	sml_loaderb_l_to_r
	dd	0
	dd	sml_loaderb_r_to_u
	dd	sml_loaderb_r_to_d
	dd	sml_loaderb_r_to_l
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0


loader_auto	db	64 dup (0)



end32save_data

start32data



loader_left	dw	2
	dw	6+s156
	dw	-2
	dw	0
	dw	2
	dw	7+s156
	dw	-2
	dw	0
	dw	2
	dw	8+s156
	dw	-2
	dw	0
	dw	2
	dw	9+s156
	dw	-2
	dw	0
	dw	0


loader_right	dw	2
	dw	10+s156
	dw	2
	dw	0
	dw	2
	dw	11+s156
	dw	2
	dw	0
	dw	2
	dw	12+s156
	dw	2
	dw	0
	dw	2
	dw	13+s156
	dw	2
	dw	0
	dw	0


loader_up	dw	1
	dw	0+s156
	dw	0
	dw	-1
	dw	1
	dw	1+s156
	dw	0
	dw	-1
	dw	1
	dw	2+s156
	dw	0
	dw	-1
	dw	0


loader_down	dw	1
	dw	3+s156
	dw	0
	dw	1
	dw	1
	dw	4+s156
	dw	0
	dw	1
	dw	1
	dw	5+s156
	dw	0
	dw	1
	dw	0


loader_st_up	dw	s156
	dw	1
	dw	1
	dw	0
	dw	0


loader_st_down	dw	s156
	dw	1
	dw	1
	dw	3
	dw	0


loader_st_left	dw	s156
	dw	1
	dw	1
	dw	6
	dw	0


loader_st_right	dw	s156
	dw	1
	dw	1
	dw	10
	dw	0


loader_r_to_u	dw	15+s156
	dw	0


loader_r_to_d	dw	14+s156
	dw	0


loader_r_to_l	dw	15+s156
	dw	0+s156
	dw	16+s156
	dw	0


loader_u_to_d	dw	16+s156
	dw	6+s156
	dw	17+s156
	dw	0


loader_u_to_l	dw	16+s156
	dw	0


loader_u_to_r	dw	15+s156
	dw	0


loader_d_to_u	dw	14+s156
	dw	10+s156
	dw	15+s156
	dw	0


loader_d_to_l	dw	17+s156
	dw	0


loader_d_to_r	dw	14+s156
	dw	0


loader_l_to_u	dw	16+s156
	dw	0


loader_l_to_d	dw	17+s156
	dw	0


loader_l_to_r	dw	17+s156
	dw	3+s156
	dw	14+s156
	dw	0


loaderb_left	dw	2
	dw	3+s157
	dw	-2
	dw	0
	dw	2
	dw	4+s157
	dw	-2
	dw	0
	dw	2
	dw	5+s157
	dw	-2
	dw	0
	dw	2
	dw	6+s157
	dw	-2
	dw	0
	dw	0


loaderb_right	dw	2
	dw	7+s157
	dw	2
	dw	0
	dw	2
	dw	8+s157
	dw	2
	dw	0
	dw	2
	dw	9+s157
	dw	2
	dw	0
	dw	2
	dw	10+s157
	dw	2
	dw	0
	dw	0


loaderb_up	dw	1
	dw	0+s156
	dw	0
	dw	-1
	dw	1
	dw	1+s156
	dw	0
	dw	-1
	dw	1
	dw	2+s156
	dw	0
	dw	-1
	dw	0


loaderb_down	dw	1
	dw	0+s157
	dw	0
	dw	1
	dw	1
	dw	1+s157
	dw	0
	dw	1
	dw	1
	dw	2+s157
	dw	0
	dw	1
	dw	0


loaderb_st_up	dw	s156
	dw	1
	dw	1
	dw	0
	dw	0


loaderb_st_down	dw	s157
	dw	1
	dw	1
	dw	0
	dw	0


loaderb_st_left	dw	s157
	dw	1
	dw	1
	dw	3
	dw	0


loaderb_st_right	dw	s157
	dw	1
	dw	1
	dw	7
	dw	0


loaderb_r_to_u	dw	15+s156
	dw	0


loaderb_r_to_d	dw	11+s157
	dw	0


loaderb_r_to_l	dw	15+s156
	dw	0+s156
	dw	17+s156
	dw	0


loaderb_u_to_d	dw	17+s156
	dw	3+s157
	dw	12+s157
	dw	0


loaderb_u_to_l	dw	16+s156
	dw	0


loaderb_u_to_r	dw	15+s156
	dw	0


loaderb_d_to_u	dw	11+s157
	dw	7+s157
	dw	15+s156
	dw	0


loaderb_d_to_l	dw	12+s157
	dw	0


loaderb_d_to_r	dw	11+s157
	dw	0


loaderb_l_to_u	dw	16+s156
	dw	0


loaderb_l_to_d	dw	12+s157
	dw	0


loaderb_l_to_r	dw	12+s157
	dw	s157
	dw	11+s157
	dw	0


sml_loader_left	dw	1
	dw	6+s158
	dw	-1
	dw	0
	dw	1
	dw	7+s158
	dw	-1
	dw	0
	dw	1
	dw	8+s158
	dw	-1
	dw	0
	dw	1
	dw	9+s158
	dw	-1
	dw	0
	dw	1
	dw	10+s158
	dw	-1
	dw	0
	dw	1
	dw	11+s158
	dw	-1
	dw	0
	dw	1
	dw	12+s158
	dw	-1
	dw	0
	dw	1
	dw	13+s158
	dw	-1
	dw	0
	dw	0


sml_loader_right	dw	1
	dw	14+s158
	dw	1
	dw	0
	dw	1
	dw	15+s158
	dw	1
	dw	0
	dw	1
	dw	16+s158
	dw	1
	dw	0
	dw	1
	dw	17+s158
	dw	1
	dw	0
	dw	1
	dw	18+s158
	dw	1
	dw	0
	dw	1
	dw	19+s158
	dw	1
	dw	0
	dw	1
	dw	20+s158
	dw	1
	dw	0
	dw	1
	dw	21+s158
	dw	1
	dw	0
	dw	0


sml_loader_up	dw	1
	dw	0+s158
	dw	0
	dw	-1
	dw	1
	dw	1+s158
	dw	0
	dw	-1
	dw	1
	dw	2+s158
	dw	0
	dw	-1
	dw	0


sml_loader_down	dw	1
	dw	3+s158
	dw	0
	dw	1
	dw	1
	dw	4+s158
	dw	0
	dw	1
	dw	1
	dw	5+s158
	dw	0
	dw	1
	dw	0


sml_loader_st_up	dw	s158
	dw	1
	dw	1
	dw	0
	dw	0


sml_loader_st_down	dw	s158
	dw	1
	dw	1
	dw	3
	dw	0


sml_loader_st_left	dw	s158
	dw	1
	dw	1
	dw	6
	dw	0


sml_loader_st_right	dw	s158
	dw	1
	dw	1
	dw	14
	dw	0


sml_loader_r_to_u	dw	23+s158
	dw	0


sml_loader_r_to_d	dw	22+s158
	dw	0


sml_loader_r_to_l	dw	23+s158
	dw	0+s158
	dw	24+s158
	dw	0


sml_loader_u_to_d	dw	24+s158
	dw	6+s158
	dw	25+s158
	dw	0


sml_loader_u_to_l	dw	24+s158
	dw	0


sml_loader_u_to_r	dw	23+s158
	dw	0


sml_loader_d_to_u	dw	22+s158
	dw	14+s158
	dw	23+s158
	dw	0


sml_loader_d_to_l	dw	25+s158
	dw	0


sml_loader_d_to_r	dw	22+s158
	dw	0


sml_loader_l_to_u	dw	24+s158
	dw	0


sml_loader_l_to_d	dw	25+s158
	dw	0


sml_loader_l_to_r	dw	25+s158
	dw	3+s158
	dw	22+s158
	dw	0


sml_loaderb_left	dw	1
	dw	3+s159
	dw	-1
	dw	0
	dw	1
	dw	4+s159
	dw	-1
	dw	0
	dw	1
	dw	5+s159
	dw	-1
	dw	0
	dw	1
	dw	6+s159
	dw	-1
	dw	0
	dw	1
	dw	7+s159
	dw	-1
	dw	0
	dw	1
	dw	8+s159
	dw	-1
	dw	0
	dw	1
	dw	9+s159
	dw	-1
	dw	0
	dw	1
	dw	10+s159
	dw	-1
	dw	0
	dw	0


sml_loaderb_right	dw	1
	dw	11+s159
	dw	1
	dw	0
	dw	1
	dw	12+s159
	dw	1
	dw	0
	dw	1
	dw	13+s159
	dw	1
	dw	0
	dw	1
	dw	14+s159
	dw	1
	dw	0
	dw	1
	dw	15+s159
	dw	1
	dw	0
	dw	1
	dw	16+s159
	dw	1
	dw	0
	dw	1
	dw	17+s159
	dw	1
	dw	0
	dw	1
	dw	18+s159
	dw	1
	dw	0
	dw	0


sml_loaderb_up	dw	1
	dw	0+s158
	dw	0
	dw	-1
	dw	1
	dw	1+s158
	dw	0
	dw	-1
	dw	1
	dw	2+s158
	dw	0
	dw	-1
	dw	0


sml_loaderb_down	dw	1
	dw	0+s159
	dw	0
	dw	1
	dw	1
	dw	1+s159
	dw	0
	dw	1
	dw	1
	dw	2+s159
	dw	0
	dw	1
	dw	0


sml_loaderb_st_up	dw	s158
	dw	1
	dw	1
	dw	0
	dw	0


sml_loaderb_st_down	dw	s159
	dw	1
	dw	1
	dw	0
	dw	0


sml_loaderb_st_left	dw	s159
	dw	1
	dw	1
	dw	3
	dw	0


sml_loaderb_st_right	dw	s159
	dw	1
	dw	1
	dw	11
	dw	0


sml_loaderb_r_to_u	dw	23+s158
	dw	0


sml_loaderb_r_to_d	dw	19+s159
	dw	0


sml_loaderb_r_to_l	dw	23+s158
	dw	0+s158
	dw	24+s158
	dw	0


sml_loaderb_u_to_d	dw	24+s158
	dw	3+s159
	dw	20+s159
	dw	0


sml_loaderb_u_to_l	dw	24+s158
	dw	0


sml_loaderb_u_to_r	dw	23+s158
	dw	0


sml_loaderb_d_to_u	dw	19+s159
	dw	11+s159
	dw	23+s158
	dw	0


sml_loaderb_d_to_l	dw	20+s159
	dw	0


sml_loaderb_d_to_r	dw	19+s159
	dw	0


sml_loaderb_l_to_u	dw	24+s158
	dw	0


sml_loaderb_l_to_d	dw	20+s159
	dw	0


sml_loaderb_l_to_r	dw	20+s159
	dw	s159
	dw	19+s159
	dw	0


rs_test_jobs	dw	c_base_sub
	dw	basic_jobs
	dw	-1



end32data

start32save_data



end32save_data
