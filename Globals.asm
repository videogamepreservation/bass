


;	The global data items


	externdef	screen_segment:word			;segment pointer to vga screen
	externdef	item_list:dword				;item pointer list
	externdef	tseq_frames:dword				;item pointer list
	externdef	amouse_x:dword				;mouse status
	externdef	amouse_y:dword
	externdef	bmouse_b:dword
	externdef	emouse_b:dword
	externdef	mouse_b:dword
	externdef	mouse_flag:dword
	externdef	mouse_type2:dword
	externdef	mouse_data2:dword
	externdef	mouse_offset_x:dword
	externdef	mouse_offset_y:dword
	externdef	system_flags:dword			;collection of flags
	externdef	original_screen_mode:byte			;screen mode on start up
	externdef	logic_list_no:dword			;current logic list
	externdef	cur_id:dword				;id being operated on
	externdef	game_grid:dword				;screen block update data
	externdef	backscreen:dword				;background screen
	externdef	game_grids:dword				;pointer to walk grid data
	externdef	anim_talk_table:dword			;table of talk anims
	externdef	move_list:dword				;half hearted list for moving compacts accross rooms
	externdef	start_of_save_data:dword			;start and end of data to save
	externdef	end_of_save_data:byte
	externdef	current_palette:dword			;palette on screen
	externdef	mice_data:dword				;pointers to mice
	externdef	object_mouse_data:dword
	externdef	text_buffer:byte				;buffer for text
	externdef	game_cycle:dword
	externdef	relative_50hz_count:dword
	externdef	game_50hz_count:dword
	externdef	monitor_auto:byte
	externdef	cur_char_set:dword
ifdef with_screen_saver
	externdef	sssss_count:dword
endif
	externdef	db_next_cycle:dword
	externdef	show_debug_vars:dword
	externdef	past_intro:dword
	externdef	work_palette:dword
	externdef	music_command_return_value:dword
	externdef	screen:dword				;current screen on view
	externdef	grid_convert_table:byte			;convert room numbers to grid numbers
	externdef	current_section:dword			;Game section for save game
	externdef	save_current_section:dword			;Game section
	externdef	current_music:dword			;music currently playing
	externdef	saved_current_music:dword			;music currently playing
	externdef	replay_version:byte
	externdef	current_version:byte
	externdef	current_music:dword
	externdef	restart_name_p:dword
	externdef	stabilise_count:dword
	externdef	save_game_text_file:dword
	externdef	save_game_name:dword
	externdef	logic_talk_button_release:dword
	externdef	computer_speed:dword
	externdef	voc_work_space:dword
	externdef	reich_door_flag:dword
	externdef	_force_sounds_off:dword
	externdef	_language:dword
	externdef	_cd_version:dword
	externdef	random:dword
	externdef	look_through:dword
	externdef	_start_flag2:dword
	externdef	config_file_present:dword
	externdef	config_name:byte
	externdef	c_text_no:dword
	externdef	music_volume:dword

;	used for cheats

	externdef	foreman_friend:dword


;	Pointers into the item list

	externdef	data_0:dword
	externdef	data_1:dword
	externdef	data_2:dword
	externdef	data_3:dword
	externdef	data_4:dword
	externdef	data_5:dword
	externdef	data_6:dword
	externdef	finger_print:byte
	externdef	screen0_low_logic:word


;	Compacts

	externdef	foster:word
	externdef	chuck_s4:word
	externdef	sc4_floor:word
	externdef	monitors_s4:word
	externdef	reich_door_20:word

;	Script variables

	externdef	script_variables:dword
	externdef	menu:dword
	externdef	layer_0_id:dword
	externdef	layer_1_id:dword
	externdef	draw_list_no:dword
	externdef	got_jammer:dword
	externdef	card_status:dword
	externdef	card_fix:dword
	externdef	mouse_status:dword
	externdef	got_sponsor:dword
	externdef	new_safe_x:dword
	externdef	tmousex:dword
	externdef	new_safe_y:dword
	externdef	tmousey:dword
	externdef	safex:dword
	externdef	safey:dword
	externdef	special_item:dword
	externdef	cursor_id:dword
	externdef	text1:dword
	externdef	get_off:dword
	externdef	flag:dword
	externdef	hit_id:dword
	externdef	rnd:dword
	externdef	mouse_list_no:dword
	externdef	o0:dword
	externdef	button:dword
	externdef	result:dword
	externdef	player_x:dword
	externdef	player_y:dword
	externdef	player_mood:dword
	externdef	player_screen:dword
	externdef	the_chosen_one:dword
	externdef	text_rate:dword
	externdef	menu_length:dword
	externdef	cur_section:dword
	externdef	scroll_offset:dword
	externdef	object_held:dword
	externdef	pointer_pen:dword
	externdef	mouse_stop:dword
	externdef	linc_digit_0:dword
	externdef	linc_digit_1:dword
	externdef	linc_digit_6:dword
	externdef	knows_port:dword
	externdef	enter_digits:dword
	externdef	fs_command:dword
	externdef	console_type:dword

;	Code globals

	externdef	change_text_sprite_colour:near
	externdef	check_module_loaded:near
	externdef	do_cross_mouse:near
	externdef	do_screen_dump:near
	externdef	do_timer_sequence:near
	externdef	start_timer_sequence:near
	externdef	anim_sequence:near
	externdef	init_virgin:near
	externdef	clear_screen:near
	externdef	control_panel:near
	externdef	display_text:near
	externdef	do_random:near
	externdef	draw_sprite:near
	externdef	fetch_key:near
	externdef	flip:near
	externdef	flush_key_buffer:near
	externdef	fn_add_human:near
	externdef	fn_close_hand:near
	externdef	fn_cross_mouse:near
	externdef	fn_disk_mouse:near
	externdef	fn_enter_section:near
	externdef	fn_fade_down:near
	externdef	fn_fade_up:near
	externdef	fn_flush_buffers:near
	externdef	fn_force_refresh:near
	externdef	fn_get_grid_values:near
	externdef	fn_kill_id:near
	externdef	fn_leave_section:near
	externdef	fn_no_human:near
	externdef	fn_normal_mouse:near
	externdef	fn_object_to_walk:near
	externdef	fn_pause_fx:near
	externdef	fn_restore_game:near
	externdef	fn_remove_grid:near
	externdef	fn_remove_object_from_walk:near
	externdef	fn_send_sync:near
	externdef	fn_set_font:near
	externdef	fn_set_palette:near
	externdef	fn_start_fx:near
	externdef	fn_start_music:near
	externdef	fn_stop_fx:near
	externdef	fn_stop_music:near
	externdef	fn_stop_voc:near
	externdef	fn_suspend_fx:near
	externdef	fn_text_kill2:near
	externdef	fn_un_pause_fx:near
	externdef	force_restart:near
	externdef	frame:near
	externdef	get_file_size:near
	externdef	get_text:near
	externdef	load_file:near
	externdef	lock_mouse:near
	externdef	unlock_mouse:near
	externdef	load_grids:near
	externdef	load_section_music:near
	externdef	low_text_manager:near
	externdef	music_command:near
	externdef	my_free:near
	externdef	my_malloc:near
	externdef	_play_voc_data__Npcii:near
	externdef	remove_mouse:near
	externdef	restart_current_music:near
	externdef	restore_file_lists:near
	externdef	restore_saved_effects_0:near
	externdef	restore_saved_effects_1:near
	externdef	restore_mouse:near
	externdef	re_create:near
	externdef	run_get_off:near
	externdef	c2_save_game_to_disk:near
	externdef	script:near
	externdef	set_palette:near
	externdef	set_stabilise:near
	externdef	sprite_engine:near
	externdef	stabilise:near
	externdef	stop_music:near
	externdef	toggle_fx_kbd:near
	externdef	toggle_ms_kbd:near
	externdef	wait_50hz:near
	externdef	wait_mouse_not_pressed:near
	externdef	wait_relative:near
	externdef	sprite_mouse:near
	externdef	trash_all_fx:near
	externdef	replace_mouse_cursors:near
	externdef	vector_to_game:near
	externdef	debug_loop:near
	externdef	check_replay_key:near
	externdef	check_replay_skip:near

	externdef	_open_for_write__Npc:near
	externdef	_open_for_read__Npc:near
	externdef	restore_mouse_data:near
	externdef	draw_new_mouse:near


;--------------------------------------------------------------------------------------------------

;	Debugging globals

ifdef debug_42

	externdef	_debug_flag:dword
	externdef	flip_grid:near
	externdef	status_int:near
	externdef	_debug_route_grid__Nps:near
	externdef	_dump_file__Npcpci:near
	externdef	debug_printf:near
	externdef	fn_printf:near
	externdef	tseq_frames:dword
	externdef	replay_data_ptr:dword
	externdef	last_speech_file:dword
	externdef	last_speech_screen:dword
	externdef	voc_chick:dword

endif

ifdef with_replay
	externdef	_do_a_replay:dword
	externdef	random:dword
	externdef	joey:word
	externdef	replay_data_len:dword
	externdef	replay_data:dword
	externdef	replay_data_ptr:dword
	externdef	switch_replay_to_record:near
	externdef	start_up_replay_file:near
	externdef	replay_changed_screen:near
	externdef	replay_record_event:near
	externdef	check_replay_mouse:near
	externdef	rewrite_replay_file:near
	externdef	replay_say_something:near
	externdef	replay_mouse_returned:near
endif



;--------------------------------------------------------------------------------------------------

ifdef mem_check

;	Memory checking globals

	externdef	backscreen:dword
	externdef	loaded_file_list:dword
	externdef	mouse_text_data:dword
	externdef	saved_data:dword
	externdef	module_list:dword
	externdef	route_grid:dword
	externdef	main_character_set:dword
	externdef	control_char_set:dword
	externdef	link_character_set:dword
	externdef	status_ch_set:dword
	externdef	k19:dword
	externdef	green_slab:dword
	externdef	mcode_table:dword
	externdef	c2_save_game_texts:dword
	externdef	dos_mem_allocated:dword
	externdef	menu_bar:word
	externdef	spp_control_panel:dword
	externdef	spp_button:dword
	externdef	spp_dn_btn:dword
	externdef	spp_save_panel:dword
	externdef	spp_yes_no:dword
	externdef	spp_slide:dword
	externdef	spp_slode:dword
	externdef	c2_palette_data:dword
	externdef	replay_data:dword
	externdef	dinner_table_area:dword
	externdef	pre_after_table_area:dword
endif

	externdef	exe_version:byte
	externdef	save_version:byte
	externdef	save_version_end:byte

ifdef with_voc_editor
	externdef	_voc_editor__Nv:near
endif

	externdef	voc_progress_report2:near
	externdef	voc_progress:dword

	externdef	noitcetorp_kcehc:near

