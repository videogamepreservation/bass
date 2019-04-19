start32code

	extrn	fn_cache_chip:near
	extrn	fn_cache_fast:near
	extrn	fn_draw_screen:near
	extrn	fn_ar:near
	extrn	fn_ar_animate:near
	extrn	fn_idle:near
	extrn	fn_interact:near
	extrn	fn_start_sub:near
	extrn	fn_they_start_sub:near
	extrn	fn_assign_base:near
	extrn	fn_disk_mouse:near
	extrn	fn_normal_mouse:near
	extrn	fn_blank_mouse:near
	extrn	fn_cross_mouse:near
	extrn	fn_cursor_right:near
	extrn	fn_cursor_left:near
	extrn	fn_cursor_down:near
	extrn	fn_open_hand:near
	extrn	fn_close_hand:near
	extrn	fn_get_to:near
	extrn	fn_set_to_stand:near
	extrn	fn_turn_to:near
	extrn	fn_arrived:near
	extrn	fn_leaving:near
	extrn	fn_set_alternate:near
	extrn	fn_alt_set_alternate:near
	extrn	fn_kill_id:near
	extrn	fn_no_human:near
	extrn	fn_add_human:near
	extrn	fn_add_buttons:near
	extrn	fn_no_buttons:near
	extrn	fn_set_stop:near
	extrn	fn_clear_stop:near
	extrn	fn_pointer_text:near
	extrn	fn_quit:near
	extrn	fn_speak_me:near
	extrn	fn_speak_me_dir:near
	extrn	fn_speak_wait:near
	extrn	fn_speak_wait_dir:near
	extrn	fn_chooser:near
	extrn	fn_highlight:near
	extrn	fn_text_kill:near
	extrn	fn_stop_mode:near
	extrn	fn_we_wait:near
	extrn	fn_send_sync:near
	extrn	fn_send_fast_sync:near
	extrn	fn_send_request:near
	extrn	fn_clear_request:near
	extrn	fn_check_request:near
	extrn	fn_start_menu:near
	extrn	fn_unhighlight:near
	extrn	fn_face_id:near
	extrn	fn_foreground:near
	extrn	fn_background:near
	extrn	fn_new_background:near
	extrn	fn_sort:near
	extrn	fn_no_sprite_engine:near
	extrn	fn_no_sprites_a6:near
	extrn	fn_reset_id:near
	extrn	fn_toggle_grid:near
	extrn	fn_pause:near
	extrn	fn_run_anim_mod:near
	extrn	fn_simple_mod:near
	extrn	fn_run_frames:near
	extrn	fn_await_sync:near
	extrn	fn_inc_mega_set:near
	extrn	fn_dec_mega_set:near
	extrn	fn_set_mega_set:near
	extrn	fn_move_items:near
	extrn	fn_new_list:near
	extrn	fn_ask_this:near
	extrn	fn_random:near
	extrn	fn_person_here:near
	extrn	fn_toggle_mouse:near
	extrn	fn_mouse_on:near
	extrn	fn_mouse_off:near
	extrn	fn_fetch_x:near
	extrn	fn_fetch_y:near
	extrn	fn_test_list:near
	extrn	fn_fetch_place:near
	extrn	fn_custom_joey:near
	extrn	fn_set_palette:near
	extrn	fn_text_module:near
	extrn	fn_change_name:near
	extrn	fn_mini_load:near
	extrn	fn_flush_buffers:near
	extrn	fn_flush_chip:near
	extrn	fn_save_coods:near
	extrn	fn_plot_grid:near
	extrn	fn_remove_grid:near
	extrn	fn_eyeball:near
	extrn	fn_cursor_up:near
	extrn	fn_leave_section:near
	extrn	fn_enter_section:near
	extrn	fn_restore_game:near
	extrn	fn_restart_game:near
	extrn	fn_new_swing_seq:near
	extrn	fn_wait_swing_end:near
	extrn	fn_skip_intro_code:near
	extrn	fn_blank_screen:near
	extrn	fn_print_credit:near
	extrn	fn_look_at:near
	extrn	fn_linc_text_module:near
	extrn	fn_text_kill2:near
	extrn	fn_set_font:near
	extrn	fn_start_fx:near
	extrn	fn_stop_fx:near
	extrn	fn_start_music:near
	extrn	fn_stop_music:near
	extrn	fn_fade_down:near
	extrn	fn_fade_up:near
	extrn	fn_quit_to_dos:near
	extrn	fn_pause_fx:near
	extrn	fn_un_pause_fx:near
	extrn	fn_printf:near

end32code

start32save_data

script_variables	dd	0 dup (0)
result	dd	0
screen	dd	0
logic_list_no	dd	141
safe_logic_list	dd	0
low_list_no	dd	0
high_list_no	dd	0
mouse_list_no	dd	0
safe_mouse_list	dd	0
draw_list_no	dd	0
second_draw_list	dd	0
do_not_use	dd	0
music_module	dd	0
cur_id	dd	0
mouse_status	dd	0
mouse_stop	dd	0
button	dd	0
but_repeat	dd	0
special_item	dd	0
get_off	dd	0
safe_click	dd	0
click_id	dd	0
player_id	dd	0
cursor_id	dd	0
pointer_pen	dd	0
last_pal	dd	0
safex	dd	0
safey	dd	0
player_x	dd	0
player_y	dd	0
player_mood	dd	0
player_screen	dd	0
old_x	dd	0
old_y	dd	0
joey_x	dd	0
joey_y	dd	0
joey_list	dd	0
flag	dd	0
hit_id	dd	0
player_target	dd	0
joey_target	dd	0
mega_target	dd	0
layer_0_id	dd	0
layer_1_id	dd	0
layer_2_id	dd	0
layer_3_id	dd	0
grid_1_id	dd	0
grid_2_id	dd	0
grid_3_id	dd	0
stop_grid	dd	0
text_rate	dd	0
text_speed	dd	0
the_chosen_one	dd	0
chosen_anim	dd	0
text1	dd	0
anim1	dd	0
text2	dd	0
anim2	dd	0
text3	dd	0
anim3	dd	0
text4	dd	0
anim4	dd	0
text5	dd	0
anim5	dd	0
text6	dd	0
anim6	dd	0
text7	dd	0
anim7	dd	0
text8	dd	0
anim8	dd	0
o0	dd	0
o1	dd	0
o2	dd	0
o3	dd	0
o4	dd	0
o5	dd	0
o6	dd	0
o7	dd	0
o8	dd	0
o9	dd	0
o10	dd	0
o11	dd	0
o12	dd	0
o13	dd	0
o14	dd	0
o15	dd	0
o16	dd	0
o17	dd	0
o18	dd	0
o19	dd	0
o20	dd	0
o21	dd	0
o22	dd	0
o23	dd	0
o24	dd	0
o25	dd	0
o26	dd	0
o27	dd	0
o28	dd	0
o29	dd	0
first_icon	dd	0
menu_length	dd	0
scroll_offset	dd	0
menu	dd	0
object_held	dd	0
icon_lit	dd	0
at_sign	dd	0
fire_exit_flag	dd	0
small_door_flag	dd	0
jobs_greet	dd	0
lamb_greet	dd	62
knob_flag	dd	0
lazer_flag	dd	0
cupb_flag	dd	0
jobs_loop	dd	0
done_something	dd	0
rnd	dd	0
jobs_text	dd	0
jobs_loc1	dd	0
jobs_loc2	dd	0
jobs_loc3	dd	0
id_talking	dd	0
alarm	dd	0
alarm_count	dd	0
clearing_alarm	dd	0
jobs_friend	dd	0
joey_born	dd	0
joey_text	dd	0
joey_peeved	dd	0
knows_linc	dd	0
linc_overmann	dd	0
reich_entry	dd	0
seen_lock	dd	0
wshop_text	dd	0
knows_firedoor	dd	0
knows_furnace	dd	0
jobs_got_spanner	dd	0
jobs_got_sandwich	dd	0
jobs_firedoor	dd	0
knows_transporter	dd	0
joey_loc1	dd	0
joey_loc2	dd	0
joey_loc3	dd	0
joey_screen	dd	0
cur_section	dd	0
old_section	dd	0
joey_section	dd	1
lamb_section	dd	2
knows_overmann	dd	0
jobs_overmann	dd	0
jobs_seen_joey	dd	0
anita_text	dd	0
anit_loc1	dd	0
anit_loc2	dd	0
anit_loc3	dd	0
lamb_friend	dd	0
lamb_sick	dd	0
lamb_crawly	dd	0
lamb_loc1	dd	0
lamb_loc2	dd	0
lamb_loc3	dd	0
lamb_got_spanner	dd	0
lamb_text	dd	0
knows_auditor	dd	0
lamb_security	dd	0
lamb_auditor	dd	0
fore_text	dd	0
transporter_alive	dd	0
anita_friend	dd	0
anita_stop	dd	0
anita_count	dd	0
knows_security	dd	0
fore_loc1	dd	0
fore_loc2	dd	0
fore_loc3	dd	0
fore_friend	dd	0
knows_dlinc	dd	0
seen_lift	dd	0
player_sound	dd	0
guard_linc	dd	0
guard_text	dd	0
guar_loc1	dd	0
guar_loc2	dd	0
guar_loc3	dd	0
guard_talk	dd	0
lamb_out	dd	0
guard_warning	dd	0
wshp_loc1	dd	0
wshp_loc2	dd	0
wshp_loc3	dd	0
jobs_linc	dd	0
knows_port	dd	0
jobs_port	dd	0
joey_overmann	dd	0
joey_count	dd	0
knows_pipes	dd	0
knows_hobart	dd	0
fore_hobart	dd	0
fore_overmann	dd	0
anit_text	dd	0
seen_eye	dd	0
anita_dlinc	dd	0
seen_dis_lift	dd	0
lamb_move_anita	dd	0
lamb_stat	dd	0
machine_stops	dd	0
guard_stat	dd	0
guard_hobart	dd	0
gordon_text	dd	0
gord_loc1	dd	0
gord_loc2	dd	0
gord_loc3	dd	0
lamb_hobart	dd	0
anita_loc1	dd	0
anita_loc2	dd	0
anita_loc3	dd	0
knows_elders	dd	0
anita_elders	dd	0
anita_overmann	dd	0
stay_here	dd	0
joey_pause	dd	0
knows_break_in	dd	0
joey_break_in	dd	0
joey_lift	dd	0
stair_talk	dd	0
blown_top	dd	0
tamper_flag	dd	0
knows_reich	dd	0
gordon_reich	dd	0
open_panel	dd	0
panel_count	dd	0
wreck_text	dd	0
press_button	dd	0
touch_count	dd	0
gordon_overmann	dd	0
lamb_reich	dd	0
exit_stores	dd	0
henri_text	dd	0
henr_loc1	dd	0
henr_loc2	dd	0
henr_loc3	dd	0
got_sponsor	dd	0
used_deodorant	dd	0
lob_dad_text	dd	0
lob_son_text	dd	0
scan_talk	dd	0
dady_loc1	dd	0
dady_loc2	dd	0
dady_loc3	dd	0
samm_loc1	dd	0
samm_loc2	dd	0
samm_loc3	dd	0
dirty_card	dd	0
wrek_loc1	dd	0
wrek_loc2	dd	0
wrek_loc3	dd	0
crushed_nuts	dd	0
got_port	dd	0
anita_port	dd	0
got_jammer	dd	0
knows_anita	dd	0
anita_hobart	dd	0
local_count	dd	0
lamb_joey	dd	0
stop_store	dd	0
knows_suit	dd	0
joey_box	dd	0
asked_box	dd	0
shell_count	dd	0
got_cable	dd	0
local_flag	dd	0
search_flag	dd	0
rad_count	dd	0
rad_text	dd	0
radm_loc1	dd	0
radm_loc2	dd	0
radm_loc3	dd	0
gordon_off	dd	0
knows_jobsworth	dd	0
rad_back_flag	dd	0
lamb_lift	dd	0
knows_cat	dd	0
lamb_screwed	dd	0
tour_flag	dd	0
foreman_reactor	dd	0
foreman_anita	dd	0
burke_text	dd	0
burk_loc1	dd	0
burk_loc2	dd	0
burk_loc3	dd	0
burke_anchor	dd	0
jason_text	dd	0
jaso_loc1	dd	0
jaso_loc2	dd	0
helg_loc2	dd	0
say_to_helga	dd	0
interest_count	dd	0
anchor_text	dd	0
anchor_overmann	dd	0
anch_loc1	dd	0
anch_loc2	dd	0
anch_loc3	dd	0
anchor_count	dd	0
lamb_anchor	dd	0
anchor_port	dd	0
knows_stephen	dd	0
knows_ghoul	dd	0
anchor_talk	dd	0
joey_hook	dd	0
joey_done_dir	dd	0
bios_loc1	dd	0
bios_loc2	dd	0
bios_loc3	dd	0
got_hook	dd	0
anchor_anita	dd	0
trev_loc1	dd	0
trev_loc2	dd	0
trev_loc3	dd	0
trevor_text	dd	0
trev_text	dd	0
trev_overmann	dd	0
lamb_smell	dd	0
art_flag	dd	0
trev_computer	dd	0
helga_text	dd	0
helg_loc1	dd	0
helg_loc3	dd	0
bios_loc4	dd	0
gallagher_text	dd	0
gall_loc1	dd	0
gall_loc2	dd	0
gall_loc3	dd	0
warn_lamb	dd	0
open_apts	dd	0
store_count	dd	0
foreman_auditor	dd	0
frozen_assets	dd	0
read_report	dd	0
seen_holo	dd	0
knows_subway	dd	0
exit_flag	dd	0
father_text	dd	0
lamb_fix	dd	0
read_briefing	dd	0
seen_shaft	dd	0
knows_mother	dd	0
console_type	dd	0
hatch_selected	dd	0
seen_walters	dd	0
joey_fallen	dd	0
jbel_loc1	dd	0
lbel_loc1	dd	0
lbel_loc2	dd	0
jobsworth_speech	dd	0
jobs_alert	dd	0
jobs_alarmed_ref	dd	0
safe_joey_recycle	dd	0
safe_joey_sss	dd	0
safe_joey_mission	dd	0
safe_trans_mission	dd	0
safe_slot_mission	dd	0
safe_corner_mission	dd	0
safe_joey_logic	dd	0
safe_gordon_speech	dd	0
safe_button_mission	dd	0
safe_dad_speech	dd	0
safe_son_speech	dd	0
safe_skorl_speech	dd	0
safe_uchar_speech	dd	0
safe_wreck_speech	dd	0
safe_anita_speech	dd	0
safe_lamb_speech	dd	0
safe_foreman_speech	dd	0
joey_42_mission	dd	0
joey_junction_mission	dd	0
safe_welder_mission	dd	0
safe_joey_weld	dd	0
safe_radman_speech	dd	0
safe_link_7_29	dd	0
safe_link_29_7	dd	0
safe_lamb_to_3	dd	0
safe_lamb_to_2	dd	0
safe_burke_speech	dd	0
safe_burke_1	dd	0
safe_burke_2	dd	0
safe_dr_1	dd	0
safe_body_speech	dd	0
joey_bell	dd	0
safe_anchor_speech	dd	0
safe_anchor	dd	0
safe_pc_mission	dd	0
safe_hook_mission	dd	0
safe_trevor_speech	dd	0
joey_fact	dd	0
safe_helga_speech	dd	0
helga_mission	dd	0
gal_bel_speech	dd	0
safe_glass_mission	dd	0
safe_lamb_fact_return	dd	0
lamb_part_2	dd	0
safe_lamb_bell_return	dd	0
safe_lamb_bell	dd	0
safe_cable_mission	dd	0
safe_foster_tour	dd	0
safe_lamb_tour	dd	0
safe_foreman_logic	dd	0
safe_lamb_leave	dd	0
safe_lamb_3	dd	0
safe_lamb_2	dd	0
into_linc	dd	0
out_10	dd	0
out_74	dd	0
safe_link_28_31	dd	0
safe_link_31_28	dd	0
safe_exit_linc	dd	0
safe_end_game	dd	0
which_linc	dd	0
lift_moving	dd	0
lift_on_screen	dd	0
barrel_on_screen	dd	0
convey_on_screen	dd	0
shades_searched	dd	0
joey_wiz	dd	0
slot_slotted	dd	0
motor_flag	dd	0
panel_flag	dd	0
switch_flag	dd	0
steam_flag	dd	0
steam_fx_no	dd	0
factory_flag	dd	0
power_door_open	dd	0
left_skull_flag	dd	0
right_skull_flag	dd	0
monitor_watching	dd	0
left_lever_flag	dd	0
right_lever_flag	dd	0
lobby_door_flag	dd	0
weld_stop	dd	0
cog_flag	dd	0
sensor_flag	dd	0
look_through	dd	0
welder_nut_flag	dd	0
s7_lift_flag	dd	0
s29_lift_flag	dd	0
whos_at_lift_7	dd	0
whos_at_lift_29	dd	0
lift_power	dd	0
whats_joey	dd	0
seen_box	dd	0
seen_welder	dd	0
flap_flag	dd	0
s15_floor	dd	8371
foreman_friend	dd	0
locker1_flag	dd	0
locker2_flag	dd	0
locker3_flag	dd	0
whats_in_locker	dd	0
knows_radsuit	dd	0
radman_anita	dd	0
at_anita	dd	0
coat_flag	dd	0
dressed_as	dd	0
s14_take	dd	0
reactor_door_flag	dd	0
joey_in_lift	dd	0
chair_27_flag	dd	0
at_body_flag	dd	0
at_gas_flag	dd	0
anchor_seated	dd	0
door_23_jam	dd	0
door_20_jam	dd	0
reich_door_flag	dd	0
reich_door_jam	dd	0
lamb_door_flag	dd	0
lamb_door_jam	dd	0
pillow_flag	dd	0
cat_food_flag	dd	0
helga_up	dd	0
got_magazine	dd	0
trevs_doing	dd	0
card_status	dd	0
card_fix	dd	0
lamb_gallager	dd	0
locker_11_flag	dd	0
ever_opened	dd	0
linc_10_flag	dd	0
chair_10_flag	dd	0
skorl_flag	dd	0
lift_pause	dd	0
lift_in_use	dd	0
gordon_back	dd	0
furnace_door_flag	dd	0
whos_with_gall	dd	0
read_news	dd	0
whos_at_lift_28	dd	0
s28_lift_flag	dd	0
mission_state	dd	0
anita_flag	dd	0
card_used	dd	0
gordon_catch	dd	0
car_flag	dd	0
first_jobs	dd	0
jobs_removed	dd	0
menu_id	dd	0
tonys_tour_flag	dd	0
joey_foster_phase	dd	0
start_info_window	dd	0
ref_slab_on	dd	0
ref_up_mouse	dd	0
ref_down_mouse	dd	0
ref_left_mouse	dd	0
ref_right_mouse	dd	0
ref_disconnect_foster	dd	0
k0	dd	0
k1	dd	0
k2	dd	0
k3	dd	0
k4	dd	0
k5	dd	0
k6	dd	0
k7	dd	0
k8	dd	0
k9	dd	0
k10	dd	0
k11	dd	0
k12	dd	0
k13	dd	0
k14	dd	0
k15	dd	0
k16	dd	0
k17	dd	0
k18	dd	0
k19	dd	0
k20	dd	0
k21	dd	0
k22	dd	0
k23	dd	0
k24	dd	0
k25	dd	0
k26	dd	0
k27	dd	0
k28	dd	0
k29	dd	0
a0	dd	0
a1	dd	0
a2	dd	0
a3	dd	0
a4	dd	0
a5	dd	0
a6	dd	0
a7	dd	0
a8	dd	0
a9	dd	0
a10	dd	0
a11	dd	0
a12	dd	0
a13	dd	0
a14	dd	0
a15	dd	0
a16	dd	0
a17	dd	0
a18	dd	0
a19	dd	0
a20	dd	0
a21	dd	0
a22	dd	0
a23	dd	0
a24	dd	0
a25	dd	0
a26	dd	0
a27	dd	0
a28	dd	0
a29	dd	0
g0	dd	0
g1	dd	0
g2	dd	0
g3	dd	0
g4	dd	0
g5	dd	0
g6	dd	0
g7	dd	0
g8	dd	0
g9	dd	0
g10	dd	0
g11	dd	0
g12	dd	0
g13	dd	0
g14	dd	0
g15	dd	0
g16	dd	0
g17	dd	0
g18	dd	0
g19	dd	0
g20	dd	0
g21	dd	0
g22	dd	0
g23	dd	0
g24	dd	0
g25	dd	0
g26	dd	0
g27	dd	0
g28	dd	0
g29	dd	0
window_subject	dd	0
file_text	dd	0
size_text	dd	0
auth_text	dd	0
note_text	dd	0
id_head_compact	dd	0
id_file_compact	dd	0
id_size_compact	dd	0
id_auth_compact	dd	0
id_note_compact	dd	0
pal_no	dd	0
strikes	dd	0
char_set_number	dd	0
eye90_blinded	dd	0
zap90	dd	0
eye90_frame	dd	0
eye91_blinded	dd	0
zap91	dd	0
eye91_frame	dd	0
bag_open	dd	0
bridge_a_on	dd	0
bridge_b_on	dd	0
bridge_c_on	dd	0
bridge_d_on	dd	0
bridge_e_on	dd	0
bridge_f_on	dd	0
bridge_g_on	dd	0
bridge_h_on	dd	0
green_slab	dd	0
red_slab	dd	0
foster_slab	dd	0
circle_slab	dd	0
slab1_mouse	dd	0
slab2_mouse	dd	0
slab3_mouse	dd	0
slab4_mouse	dd	0
slab5_mouse	dd	0
at_guardian	dd	0
guardian_there	dd	1
crystal_shattered	dd	0
virus_taken	dd	0
fs_command	dd	0
enter_digits	dd	0
next_page	dd	0
linc_digit_0	dd	0
linc_digit_1	dd	0
linc_digit_2	dd	0
linc_digit_3	dd	0
linc_digit_4	dd	0
linc_digit_5	dd	0
linc_digit_6	dd	0
linc_digit_7	dd	0
linc_digit_8	dd	0
linc_digit_9	dd	0
ref_std_on	dd	0
ref_std_exit_left_on	dd	0
ref_std_exit_right_on	dd	0
ref_advisor_188	dd	0
ref_shout_action	dd	0
ref_mega_click	dd	0
ref_mega_action	dd	0
ref_walter_speech	dd	0
ref_joey_medic	dd	0
ref_joey_med_logic	dd	0
ref_joey_med_mission72	dd	0
ref_ken_logic	dd	0
ref_ken_speech	dd	0
ref_ken_mission_hand	dd	0
ref_sc70_iris_opened	dd	0
ref_sc70_iris_closed	dd	0
ref_foster_enter_boardroom	dd	0
ref_father_speech	dd	0
ref_foster_enter_new_boardroom	dd	0
ref_hobbins_speech	dd	0
ref_sc82_jobs_sss	dd	0
brickwork	dd	0
door_67_68_flag	dd	1
crowbar_in_clot	dd	0
clot_ruptured	dd	0
clot_repaired	dd	0
walt_text	dd	0
walt_loc1	dd	0
walt_loc2	dd	0
walt_loc3	dd	0
walt_count	dd	0
medic_text	dd	0
seen_room_72	dd	0
seen_tap	dd	0
joey_med_seen72	dd	0
seen_secure_door	dd	0
ask_secure_door	dd	0
sc70_iris_flag	dd	3
sc70_iris_frame	dd	0
foster_on_sc70_iris	dd	0
sc70_grill_flag	dd	0
sc71_charging_flag	dd	0
sc72_slime_flag	dd	0
sc72_witness_sees_foster	dd	0
sc72_witness_killed	dd	0
sc73_gallagher_killed	dd	0
sc73_removed_board	dd	0
sc73_searched_corpse	dd	0
door_73_75_flag	dd	1
sc74_sitting_flag	dd	0
sc75_crashed_flag	dd	0
sc75_tissue_infected	dd	0
sc75_tongs_flag	dd	0
sc76_cabinet1_flag	dd	1
sc76_cabinet2_flag	dd	1
sc76_cabinet3_flag	dd	1
sc76_board_flag	dd	0
sc76_ken_prog_flag	dd	0
sc76_and2_up_flag	dd	0
ken_text	dd	0
ken_door_flag	dd	0
sc77_foster_hand_flag	dd	0
sc77_ken_hand_flag	dd	0
door_77_78_flag	dd	1
sc80_exit_flag	dd	1
ref_danielle_speech	dd	0
ref_danielle_go_home	dd	0
ref_spunky_go_home	dd	0
ref_henri_speech	dd	0
ref_buzzer_speech	dd	0
ref_foster_visit_dani	dd	0
ref_danielle_logic	dd	0
ref_jukebox_speech	dd	0
ref_vincent_speech	dd	0
ref_eddie_speech	dd	0
ref_blunt_speech	dd	0
ref_dani_answer_phone	dd	0
ref_spunky_see_video	dd	0
ref_spunky_bark_at_foster	dd	0
ref_spunky_smells_food	dd	0
ref_barry_speech	dd	0
ref_colston_speech	dd	0
ref_gallagher_speech	dd	0
ref_babs_speech	dd	0
ref_chutney_speech	dd	0
ref_foster_enter_court	dd	0
dani_text	dd	0
dani_loc1	dd	0
dani_loc2	dd	0
dani_loc3	dd	0
dani_buff	dd	0
dani_huff	dd	0
mother_hobart	dd	0
foster_id_flag	dd	0
knows_spunky	dd	0
dog_fleas	dd	0
op_flag	dd	0
chat_up	dd	0
buzz_loc1	dd	0
buzz_loc2	dd	0
blunt_text	dd	0
blun_loc1	dd	0
blun_loc2	dd	0
blun_loc3	dd	0
blunt_dan_info	dd	0
vincent_text	dd	0
vinc_loc1	dd	0
vinc_loc2	dd	0
vinc_loc3	dd	0
eddie_text	dd	0
eddi_loc1	dd	0
eddi_loc2	dd	0
eddi_loc3	dd	0
knows_dandelions	dd	0
barry_text	dd	0
bazz_loc1	dd	0
bazz_loc2	dd	0
bazz_loc3	dd	0
seen_cellar_door	dd	0
babs_text	dd	0
babs_loc1	dd	0
babs_loc2	dd	0
babs_loc3	dd	0
colston_text	dd	0
cols_loc1	dd	0
cols_loc2	dd	0
cols_loc3	dd	0
jukebox	dd	0
knows_soaking	dd	0
knows_complaint	dd	0
dog_bite	dd	0
new_prints	dd	0
knows_virus	dd	0
been_to_court	dd	0
danielle_target	dd	0
spunky_target	dd	0
henri_forward	dd	0
sc31_lift_flag	dd	1
sc31_food_on_plank	dd	0
sc31_spunky_at_plank	dd	0
dog_in_lake	dd	0
sc32_lift_flag	dd	1
sc33_shed_door_flag	dd	1
gardener_up	dd	0
babs_x	dd	0
babs_y	dd	0
foster_caching	dd	0
colston_caching	dd	0
band_playing	dd	1
colston_at_table	dd	1
sc36_next_dealer	dd	16731
sc36_door_flag	dd	1
sc37_door_flag	dd	2
sc37_lid_loosened	dd	0
sc37_lid_used	dd	0
sc37_standing_on_box	dd	0
sc37_box_broken	dd	0
sc37_grill_state	dd	0
got_dog_biscuits	dd	0
sc38_video_playing	dd	0
dani_on_phone	dd	0
sc40_locker_1_flag	dd	1
sc40_locker_2_flag	dd	1
sc40_locker_3_flag	dd	1
sc40_locker_4_flag	dd	1
sc40_locker_5_flag	dd	1
seen_anita_corpse	dd	0
spunky_at_lift	dd	0
court_text	dd	0
blunt_knew_jobs	dd	0
credit_1_text	dd	0
credit_2_text	dd	0
id_credit_1	dd	0
id_credit_2	dd	0
glass_stolen	dd	0
foster_at_plank	dd	0
foster_at_guard	dd	0
man_talk	dd	0
man_loc1	dd	0
man_loc2	dd	0
man_loc3	dd	0

end32save_data

start32data

mcode_table	dd	offset fn_cache_chip
	dd	offset fn_cache_fast
	dd	offset fn_draw_screen
	dd	offset fn_ar
	dd	offset fn_ar_animate
	dd	offset fn_idle
	dd	offset fn_interact
	dd	offset fn_start_sub
	dd	offset fn_they_start_sub
	dd	offset fn_assign_base
	dd	offset fn_disk_mouse
	dd	offset fn_normal_mouse
	dd	offset fn_blank_mouse
	dd	offset fn_cross_mouse
	dd	offset fn_cursor_right
	dd	offset fn_cursor_left
	dd	offset fn_cursor_down
	dd	offset fn_open_hand
	dd	offset fn_close_hand
	dd	offset fn_get_to
	dd	offset fn_set_to_stand
	dd	offset fn_turn_to
	dd	offset fn_arrived
	dd	offset fn_leaving
	dd	offset fn_set_alternate
	dd	offset fn_alt_set_alternate
	dd	offset fn_kill_id
	dd	offset fn_no_human
	dd	offset fn_add_human
	dd	offset fn_add_buttons
	dd	offset fn_no_buttons
	dd	offset fn_set_stop
	dd	offset fn_clear_stop
	dd	offset fn_pointer_text
	dd	offset fn_quit
	dd	offset fn_speak_me
	dd	offset fn_speak_me_dir
	dd	offset fn_speak_wait
	dd	offset fn_speak_wait_dir
	dd	offset fn_chooser
	dd	offset fn_highlight
	dd	offset fn_text_kill
	dd	offset fn_stop_mode
	dd	offset fn_we_wait
	dd	offset fn_send_sync
	dd	offset fn_send_fast_sync
	dd	offset fn_send_request
	dd	offset fn_clear_request
	dd	offset fn_check_request
	dd	offset fn_start_menu
	dd	offset fn_unhighlight
	dd	offset fn_face_id
	dd	offset fn_foreground
	dd	offset fn_background
	dd	offset fn_new_background
	dd	offset fn_sort
	dd	offset fn_no_sprite_engine
	dd	offset fn_no_sprites_a6
	dd	offset fn_reset_id
	dd	offset fn_toggle_grid
	dd	offset fn_pause
	dd	offset fn_run_anim_mod
	dd	offset fn_simple_mod
	dd	offset fn_run_frames
	dd	offset fn_await_sync
	dd	offset fn_inc_mega_set
	dd	offset fn_dec_mega_set
	dd	offset fn_set_mega_set
	dd	offset fn_move_items
	dd	offset fn_new_list
	dd	offset fn_ask_this
	dd	offset fn_random
	dd	offset fn_person_here
	dd	offset fn_toggle_mouse
	dd	offset fn_mouse_on
	dd	offset fn_mouse_off
	dd	offset fn_fetch_x
	dd	offset fn_fetch_y
	dd	offset fn_test_list
	dd	offset fn_fetch_place
	dd	offset fn_custom_joey
	dd	offset fn_set_palette
	dd	offset fn_text_module
	dd	offset fn_change_name
	dd	offset fn_mini_load
	dd	offset fn_flush_buffers
	dd	offset fn_flush_chip
	dd	offset fn_save_coods
	dd	offset fn_plot_grid
	dd	offset fn_remove_grid
	dd	offset fn_eyeball
	dd	offset fn_cursor_up
	dd	offset fn_leave_section
	dd	offset fn_enter_section
	dd	offset fn_restore_game
	dd	offset fn_restart_game
	dd	offset fn_new_swing_seq
	dd	offset fn_wait_swing_end
	dd	offset fn_skip_intro_code
	dd	offset fn_blank_screen
	dd	offset fn_print_credit
	dd	offset fn_look_at
	dd	offset fn_linc_text_module
	dd	offset fn_text_kill2
	dd	offset fn_set_font
	dd	offset fn_start_fx
	dd	offset fn_stop_fx
	dd	offset fn_start_music
	dd	offset fn_stop_music
	dd	offset fn_fade_down
	dd	offset fn_fade_up
	dd	offset fn_quit_to_dos
	dd	offset fn_pause_fx
	dd	offset fn_un_pause_fx
	dd	offset fn_printf

end32data

