include_macros  equ     1
include_deb_mac equ     1
include_flags   equ     1
include_error_codes equ	1
	include include.asm


music_base_file equ     60200

files_per_section       equ     4

rl_mboard_offset        equ     0
rl_max_music_size       equ     62000
rl_max_fx_size  equ     150000

sb_mboard_offset        equ     2
sb_max_music_size       equ     56000
sb_max_fx_size  equ     217000


sfxf_start_delay        equ     80h
sfxf_save       equ     20h


start32data
	extrn __x386_zero_base_selector:word    ;data selector
	extrn   code16_seg:word
	extrn   _force_roland:dword

driver_add      dd      ?                               ;32 bit address of driver
driver_seg      dw      ?                               ;real mode segment of driver

fx_add  dd      ?                               ;32 bit address of fx
fx_seg  dw      ?                               ;real mode segment of fx

voc_work_space  dd      ?                               ;32 bit pointer to 64k voc buffer
voc_fx_space    dd      ?                               ;32 bit pointer to 64k voc buffer

voc_work_seg    dw      ?                               ;real mode segment of voc buffer
voc_fx_seg      dw      ?                               ;real mode segment of voc buffer

	align 4

mboard_offset   dd      0                               ;0 = roland, 2 = adlib
max_music_size  dd      0
max_fx_size     dd      0

current_music   dd      -1                              ;music currently playing

adlibflag2      db      0
rolandflag2     db      0
tandyflag2      db      0
sblflag2        db      0

portaddress     dw      0C0h    ; tandy sound IO port address
ALport  dw      388h            ; AdLib Port Address (may change)

cfg_ports       dw      0,220h,240h,260h,280h
cfg_irq db      7,2,5,7,10
cfg_dma db      1,0,1,2,3,4,5,6,7

	align   4

fx_vol_0x       db      ?                               ;store for current fx volumes
fx_vol_1x       db      ?

	align 4


;       Special music data

stfx_cur_snd    dd      ?                               ;stores for fx being processed
stfx_cur_chn    dd      ?


music_list      dd      fx_press_bang                   ;256 banging of the press
	dd      fx_press_hiss                   ;257 hissing press
	dd      fx_wind_howl                    ;258 howling wind
	dd      fx_spanner_clunk                        ;259 spanner in works
	dd      fx_reichs_fish                  ;260 Reichs fish
	dd      fx_explosion                    ;261 panel blows open
	dd      fx_wind_3                       ;262 single steam
	dd      fx_open_door                    ;263 general open door
	dd      fx_open_lamb_door                       ;264 lamb door opens
	dd      fx_comp_bleeps                  ;265 scanner bleeps
	dd      fx_helmet_down_3                        ;266
	dd      fx_helmet_up_3                  ;267
	dd      fx_helmet_grind                 ;268
	dd      fx_lift_close_29                        ;269 rm 29 lift closes
	dd      fx_lift_open_29                 ;270 rm 29 lift opens
	dd      fx_computer_3                   ;271 rm 29 lift arrives
	dd      fx_level_3_ping                 ;272 background noise in room 4
	dd      fx_lift_alarm                   ;273 loader alarm
	dd      fx_null                         ;274 furnace room background noise
	dd      fx_rm3_lift_moving              ;275 lift moving in room 3
	dd      fx_lathe                                ;276 jobsworth lathe
	dd      fx_factory_sound                        ;277 factory background sound
	dd      fx_weld                         ;278 do some welding
	dd      fx_lift_close_7                 ;279 rm 7 lift closes
	dd      fx_lift_open_7                  ;280 rm 7 lift opens
	dd      fx_lift_arrive_7                        ;281 rm 7 lift arrives
	dd      fx_lift_moving                  ;282 lift moving
	dd      fx_scanner                      ;283 scanner operating
	dd      fx_force_fire_door              ;284 Force fire door open
	dd      fx_null                         ;285 General door creak

	dd      fx_phone                                ;286 telephone
	dd      fx_lazer                                ;287 lazer
	dd      fx_lazer                                ;288 lazer
	dd      fx_anchor_fall                  ;289 electric   ;not used on amiga
	dd      fx_weld12                       ;290 welding in room 12 (not joey)
	dd      fx_hello_helga                  ;291 helga appears
	dd      fx_byee_helga                   ;292 helga disapears
	dd      fx_null                         ;293 smash through window               ;doesn't exist

	dd      fx_pos_key                      ;294
	dd      fx_neg_key                      ;295
	dd      fx_s2_helmet                    ;296 ;helmet down section 2
	dd      fx_s2_helmet                    ;297 ;  "      up    "    "
	dd      fx_lift_arrive_7                        ;298 ;security door room 7
	dd      fx_null                         ;299
	dd      fx_rope_creak                   ;300
	dd      fx_crowbar_wooden                       ;301
	dd      fx_fall_thru_box                        ;302
	dd      fx_use_crowbar_grill            ;303
	dd      fx_use_secateurs                        ;304
	dd      fx_grill_creak                  ;305
	dd      fx_timber_cracking              ;306
	dd      fx_masonry_fall                 ;307
	dd      fx_masonry_fall                 ;308
	dd      fx_crowbar_plaster              ;309
	dd      fx_prise_brick                  ;310
	dd      fx_brick_hit_foster             ;311
	dd      fx_spray_on_skin                        ;312
	dd      fx_hit_crowbar_brick            ;313
	dd      fx_drop_crowbar                 ;314
	dd      fx_fire_crackle_in_pit          ;315
	dd      fx_remove_bar_grill             ;316
	dd      fx_liquid_bubble                        ;317
	dd      fx_liquid_drip                  ;318
	dd      fx_guard_fall                   ;319
	dd      fx_sc74_pod_down                        ;320
	dd      fx_hiss_in_nitrogen             ;321
	dd      fx_null                         ;322
	dd      fx_hit_joey1                    ;323
	dd      fx_hit_joey2                    ;324
	dd      fx_medi_stab_gall                       ;325
	dd      fx_gall_drop                    ;326
	dd      fx_null                         ;327
	dd      fx_null                         ;328
	dd      fx_null                         ;329
	dd      fx_big_tent_gurgle              ;330
	dd      fx_null                         ;331
	dd      fx_orifice_swallow_drip         ;332
	dd      fx_brick_hit_plank              ;333
	dd      fx_goo_drip                     ;334
	dd      fx_plank_vibrating              ;335
	dd      fx_splash                       ;336
	dd      fx_buzzer                       ;337
	dd      fx_shed_door_creak              ;338
	dd      fx_dog_yap_outdoors             ;339
	dd      fx_dani_phone_ring              ;340
	dd      fx_locker_creak_open            ;341
	dd      fx_judges_gavel1                        ;342
	dd      fx_dog_yap_indoors              ;343
	dd      fx_brick_hit_plank              ;344
	dd      fx_brick_hit_plank              ;345
	dd      fx_shaft_industrial_noise               ;346
	dd      fx_judges_gavel2                        ;347
	dd      fx_judges_gavel3                        ;348
	dd      fx_elevator_4                   ;349
	dd      fx_lift_closing                 ;350
	dd      fx_null                         ;351
	dd      fx_null                         ;352
	dd      fx_sc74_pod_down                        ;353

	dd      fx_null                         ;354
	dd      fx_null                         ;355
	dd      fx_heartbeat                    ;356
	dd      fx_star_trek_2                  ;357
	dd      fx_null                         ;358
	dd      fx_null                         ;359
	dd      fx_null                         ;350
	dd      fx_null                         ;361
	dd      fx_null                         ;362
	dd      fx_null                         ;363
	dd      fx_null                         ;364
	dd      fx_null                         ;365
	dd      fx_break_crystals                       ;366
	dd      fx_disintegrate                 ;367
	dd      fx_statue_on_armour             ;368
	dd      fx_null                         ;369
	dd      fx_null                         ;360
	dd      fx_ping                         ;371
	dd      fx_null                         ;372
	dd      fx_door_slam_under              ;373
	dd      fx_null                         ;374
	dd      fx_null                         ;375
	dd      fx_null                         ;376
	dd      fx_null                         ;377
	dd      fx_null                         ;378
	dd      fx_null                         ;379
	dd      fx_steam1                       ;380
	dd      fx_steam2                       ;381
	dd      fx_steam2                       ;382
	dd      fx_steam3                       ;383
	dd      fx_null                         ;384
	dd      fx_null                         ;385
	dd      fx_fact_sensor                  ;386            Sensor in Potts' room
	dd      fx_null                         ;387
	dd      fx_null                         ;388
	dd      fx_null                         ;389
	dd      fx_null                         ;390
	dd      fx_null                         ;391
	dd      fx_null                         ;392
	dd      fx_null                         ;393

	dd      fx_25_weld                      ;394            my anchor weld bodge

max_fx_number   equ     393


;       Non-existant effect

fx_null db      0                               ;fx no
	db      0                               ;flags
	db      200,127,127                     ;room,volume (adlib / roland)
	db      -1

fx_level_3_ping db      1
	db      0
	db      28,63,63
	db      29,63,63
	db      31,63,63
	db      -1

fx_factory_sound        db      1                               ;fx no
	db      sfxf_save                       ;flags
	db      -1,30,30                                ;room,volume (adlib / roland)

fx_crowbar_plaster      db      0 dup (0)
fx_masonry_fall db      1                               ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_prise_brick  db      0 dup (0)
fx_rope_creak   db      2                               ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_ping db      0 dup (0)
fx_force_fire_door      db      3
	db      0
	db      -1,127,127

fx_brick_hit_foster db  3                               ;fx no
	db      10+sfxf_start_delay             ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_brick_hit_plank      db      3                               ;fx no
	db      8+sfxf_start_delay              ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_rm3_lift_moving      db      4                               ;fx no
	db      sfxf_save                       ;flags
	db      3,127,127                       ;room,volume (adlib / roland)
	db      2,127,127                       ;room,volume (adlib / roland)
	db      -1

fx_weld db      4                               ;fx no
	db      0                               ;flags
	db      15,127,127                      ;room,volume (adlib / roland)
	db      7,127,127                       ;room,volume (adlib / roland)
	db      6,60,60                         ;room,volume (adlib / roland)
	db      12,60,60                                ;room,volume (adlib / roland)
	db      13,60,60                                ;room,volume (adlib / roland)
	db      -1

fx_weld12       db      4                               ;fx no
	db      0                               ;flags
	db      12,127,127                      ;room,volume (adlib / roland)
	db      -1

fx_spray_on_skin        db      4                               ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_plank_vibrating      db      4                               ;fx no
	db      6+sfxf_start_delay              ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_press_bang   db      5                               ;fx no
	db      0                               ;flags
	db      0,50,100                        ;room,volume (adlib / roland)
	db      -1

fx_spanner_clunk        db      5                               ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_break_crystals       db      5                               ;fx no
	db      0                               ;flags
	db      96,127,127                      ;room,volume (adlib / roland)
	db      -1

fx_press_hiss   db      6                               ;fx no
	db      0                               ;flags
	db      0,40,40                         ;room,volume (adlib / roland)
	db      -1

fx_open_door    db      6                               ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_open_lamb_door       db      6                               ;fx no
	db      0                               ;flags
	db      20,127,127                      ;room,volume (adlib / roland)
	db      21,127,127                      ;room,volume (adlib / roland)
	db      -1

fx_splash       db      6                               ;fx no
	db      22+sfxf_start_delay             ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_disintegrate db      7                               ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_buzzer       db      7                               ;fx no
	db      4+sfxf_start_delay              ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_lathe        db      7                               ;fx no
	db      sfxf_save                       ;flags
	db      4,60,60                         ;room,volume (adlib / roland)
	db      2,20,20
	db      -1

fx_hit_crowbar_brick db 7                               ;fx no
	db      9+sfxf_start_delay              ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_hello_helga  db      0 dup (0)
fx_statue_on_armour db  8                               ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_lift_alarm   db      8                               ;fx no
	db      sfxf_save                       ;flags
	db      2,63,63                       ;room,volume (adlib / roland)
	db      -1

fx_drop_crowbar db      8                               ;fx no
	db      5+sfxf_start_delay              ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_byee_helga   db      9                               ;fx no
	db      3+sfxf_start_delay              ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_shed_door_creak      db      0 dup (0)
fx_explosion    db      10                              ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_fire_crackle_in_pit db       9                               ;fx no
	db      sfxf_save                       ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_remove_bar_grill db  10                              ;fx no
	db      7+sfxf_start_delay              ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_grill_creak  db      10                              ;fx no
	db      43+sfxf_start_delay             ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_steam1       db      11                              ;fx no
	db      sfxf_save                       ;flags
	db      18,20,20                                ;room,volume (adlib / roland)
	db      -1

fx_steam2       db      11                              ;fx no
	db      sfxf_save                       ;flags
	db      18,63,63                                ;room,volume (adlib / roland)
	db      -1

fx_steam3       db      11                              ;fx no
	db      sfxf_save                       ;flags
	db      18,127,127                      ;room,volume (adlib / roland)
	db      -1

fx_crowbar_wooden       db      0 dup (0)
fx_helmet_down_3        db      11                              ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_guard_fall   db      11                              ;fx no
	db      4                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_furnace      db      11                              ;fx no
	db      0                               ;flags
	db      3,90,90                         ;room,volume (adlib / roland)
	db      -1

fx_fall_thru_box        db      0 dup (0)
fx_lazer        db      0 dup (0)                       ;identical
fx_scanner      db      0 dup (0)                       ;identical
fx_helmet_up_3  db      12                              ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_liquid_bubble        db      12                              ;fx no
	db      sfxf_save                       ;flags
	db      80,127,127                      ;room,volume (adlib / roland)
	db      72,127,127                      ;room,volume (adlib / roland)
	db      -1

fx_liquid_drip  db      13                              ;fx no
	db      6+sfxf_start_delay              ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_goo_drip     db      13                              ;fx no
	db      5+sfxf_start_delay              ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_comp_bleeps  db      13                              ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_use_crowbar_grill db 13                              ;fx no
	db      34+sfxf_start_delay             ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_helmet_grind db      14                              ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_lift_moving  db      14                              ;fx no
	db      sfxf_save                       ;flags
	db      7,127,127                       ;room,volume (adlib / roland)
	db      29,127,127                      ;room,volume (adlib / roland)
	db      -1

fx_use_secateurs        db      14                              ;fx no
	db      18+sfxf_start_delay             ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_hit_joey1    db      14                              ;fx no
	db      7+sfxf_start_delay              ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_hit_joey2    db      14                              ;fx no
	db      13+sfxf_start_delay             ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_dani_phone_ring      db      0 dup (0)
fx_sc74_pod_down        db      0 dup (0)
fx_phone        db      0 dup (0)
fx_25_weld      db      15                              ;welding in room 25
	db      0
	db      -1,127,127

fx_lift_open_7  db      15                              ;fx no
	db      0                               ;flags
	db      7,127,127                       ;room,volume (adlib / roland)
	db      -1

fx_lift_close_7 db      16                              ;fx no
	db      0                               ;flags
	db      7,127,127                       ;room,volume (adlib / roland)
	db      -1

fx_s2_helmet    db      0 dup (0)
fx_hiss_in_nitrogen db  16                              ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_dog_yap_indoors      db      16                              ;fx no
	db      0                               ;flags
	db      38,127,127                      ;room,volume (adlib / roland)
	db      -1

fx_dog_yap_outdoors db  16                              ;fx no
	db      0                               ;flags
	db      31,127,127                      ;room,volume (adlib / roland)
	db      30,40,40                                ;room,volume (adlib / roland)
	db      32,40,40                                ;room,volume (adlib / roland)
	db      33,40,40                                ;room,volume (adlib / roland)
	db      -1

fx_locker_creak_open db 0 dup (0)
fx_big_tent_gurgle      db      17                              ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_wind_howl	db      17                              ;fx no
	db      sfxf_save                       ;flags
	db      1,127,127                       ;room,volume (adlib / roland)
	db      -1

fx_lift_open_29	db      17                              ;fx no
	db      0                               ;flags
	db      29,127,127                      ;room,volume (adlib / roland)
	db      -1

fx_lift_arrive_7	db      17                              ;fx no
	db      0                               ;flags
	db      7,63,63                         ;room,volume (adlib / roland)
	db      -1

fx_lift_close_29	db      18                              ;fx no
	db      0                               ;flags
	db      29,127,127                      ;room,volume (adlib / roland)
	db      28,127,127                      ;room,volume (adlib / roland)
	db      -1

fx_shaft_industrial_noise db 18                         ;fx no
	db      sfxf_save                       ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_gall_drop	db      18                              ;fx no
	db      29+sfxf_start_delay             ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_door_slam_under	db      19                              ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_reichs_fish  db      19                              ;fx no
	db      sfxf_save                       ;flags
	db      -1,60,60                                ;room,volume (adlib / roland)

fx_judges_gavel1        db      19                              ;fx no
	db      13+sfxf_start_delay             ;flags
	db      -1,60,60                                ;room,volume (adlib / roland)

fx_judges_gavel2        db      19                              ;fx no
	db      16+sfxf_start_delay             ;flags
	db      -1,90,90                                ;room,volume (adlib / roland)

fx_judges_gavel3        db      19                              ;fx no
	db      19+sfxf_start_delay             ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_wind_3       db      0 dup (0)
fx_fact_sensor  db      20
	db      sfxf_save                       ;flags
	db      -1,60,60

fx_medi_stab_gall       db      20                              ;fx no
	db      17+sfxf_start_delay             ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_computer_3   db      21                              ;fx no
	db      sfxf_save                       ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_timber_cracking      db      21                              ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_anchor_fall  db      0 dup (0)
fx_elevator_4   db      22                              ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_star_trek_2  db      22                              ;fx no
	db      sfxf_save                       ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_lift_closing db      23                              ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_heartbeat    db      23                              ;fx no
	db      11+sfxf_start_delay             ;flags
	db      67,60,60
	db      68,60,60
	db      69,60,60
	db      77,20,20
	db      78,50,50
	db      79,70,70
	db      80,127,127
	db      81,60,60                                ;6 room,vol
	db      -1

fx_pos_key      db      25                              ;fx no
	db      2+sfxf_start_delay              ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)

fx_neg_key      db      26                              ;fx no
	db      2+sfxf_start_delay              ;flags
	db      -1,100,100                      ;room,volume (adlib / roland)

fx_orifice_swallow_drip db 28                           ;fx no
	db      0                               ;flags
	db      -1,127,127                      ;room,volume (adlib / roland)


	align 4

end32data


start32save_data

saved_current_music dd  0

max_queued_fx   equ     4

queue_fx        struc

count   db      0
fx_no   db      0
chan    db      0
vol     db      0

queue_fx        ends

fx_queue        queue_fx max_queued_fx dup (<>)

save_fx_0       dd      0               ;stores for fx that need restarting on restore
save_fx_1       dd      0

	align 4

end32save_data




start32code
	extrn   __x386_memlock:near

init_music      proc

;       If force sounds off option has been selected then don't install anything

	test    [_force_sounds_off],-1
	jne     init_music_ret

ifdef no_music
	ret
endif


	test    [config_file_present],-1                                ;is there a config file
	je      test_anyway

	cmp     1[config_name],1
	je      got_roland
	jmp     got_blaster

test_anyway:

ifdef cd_version_prot
	jmp	got_blaster
endif


;       -----------------------------------------
;       Routine to detect presence of sound cards
;       -----------------------------------------

;       NOTE that Soundblaster will give positive results for
;       both sblflag and adlibflag

;       sound cards supported ...

;       AdLib
;       Roland LAPC1    ; bug removed 03.10.92
;       Tandy TI sound chip
;       Soundblaster    ; added 23.03.92

;       -----------------------------------------
;       these bytes tell you whether each card is
;       attached - zero means not available
;       -----------------------------------------

detect: mov     alport,388h
	call    adlib_sub
	mov     adlibflag2,al
ifdef dont_check_rlnd
	mov     rolandflag2,0
else
	call    testroland
	mov     rolandflag2,al
endif
	call    testtandy
	mov     tandyflag2,al

;       Soundblaster -
;       detect adlib but at Soundblaster addresses

;       possibilities are 210h/220h/230h/240h/250h/260h/270h


	mov     alport,228h     ; factory setting
	call    adlib_sub       ; ( most likely to be used )
	or      al,al
	jne     got_sbl

;       some of these ports will no doubt generate conflicts
;       my driver doesn't check them unless a punter specifically asks

	mov     alport,218h     ; try others
	call    adlib_sub
	or      al,al
	jne     got_sbl

	mov     alport,238h
	call    adlib_sub
	or      al,al
	jne     got_sbl

	mov     alport,248h
	call    adlib_sub
	or      al,al
	jne     got_sbl

	mov     alport,258h
	call    adlib_sub
	or      al,al
	jne     got_sbl

	mov     alport,268h
	call    adlib_sub
	or      al,al
	jne     got_sbl

	mov     alport,278h
	call    adlib_sub

got_sbl:        mov     sblflag2,al

	jmp     music_checked


;       ********************************

;       --------------------------------
;       Test if AdLib Sound Card present
;       --------------------------------
;       on exit :
;       al = 1 if present , 0 if not present

AdLib_sub:      push    bx
	push    cx
	push    dx

	mov     dx,ALport
	mov     ax,6004h
	call    WriteAdLib      ; reset timer-1 and timer-2
	mov     ax,8004h
	call    WriteAdLib      ; reset the IRQ
	in      al,dx           ; read the status register
	push    ax              ; save the result

	mov     ax,0ff02h
	call    WriteAdLib      ; set timer-1 to 0ffh
	mov     ax,2104h
	call    WriteAdLib      ; unmask and start timer-1

	mov     bx,1FFFh-67     ; wait at least 80us
	call    time_out

	in      al,dx           ; read status
	push    ax              ; save result
	mov     ax,6004h
	call    WriteAdLib      ; reset timer-1 and timer-2
	mov     ax,8004h
	call    WriteAdLib      ; reset the IRQ
	pop     ax              ; al - second read
	pop     bx              ; bl - first read
	and     al,0e0h         ; mask off the bits
	and     bl,0e0h

	jne     NotPresent

	cmp     al,0C0h
	jne     NotPresent

@@present:      mov     eax,1
	pop     dx
	pop     cx
	pop     bx
	ret

NotPresent:     xor     eax,eax
	pop     dx
	pop     cx
	pop     bx
	ret

;       ----------------------------------
;       Write a value to an AdLib register
;       AH holds data , AL holds register
;       ----------------------------------

WriteAdLib:     push    bx
	push    dx
	mov     dx,ALport
	out     dx,al

; wait for at least 3.3 microseconds

	mov     bx,1FFFh-3
	call    time_out

	mov     al,ah
	inc     dx              ; dx now data reg
	out     dx,al

; now wait about 23 microseconds

	mov     bx,1FFFh-19
	call    time_out

	pop     dx
	pop     bx
	ret


port_b  equ     61h

;       Timer Chip Addresses ....

timer_0 =       40h     ; Timer Channel 0
timer_1 =       41h     ; Timer Channel 1
timer_2 =       42h     ; Timer Channel 2
timer_ctrl      =       43h     ; Timer Control Register

; Timer Control Register Looks Like This ....

;       Bit 0   if 0,Binary Data ; else BCD
;       Bit 3-1 Mode ( 0 - 5 )
;       Bit 5-4 Type of Operation ...   00 = Move Counter Value to Latch
;                                       01 = Read/Write Hi-Byte Only
;                                       10 = Read/Write Lo-Byte Only
;                                       11 = Read/Write Hi- then Lo-Byte
;       Bit 7-6 Channel Number , 0-2

;       ----------------------------------
;       wait for a specific amount of time
;       ----------------------------------
;       bx = 1FFFh minus number of ticks to wait

time_out:       push    ax
	mov     al,10110110b    ; channel 2 / read/write lo then hi
	out     timer_ctrl,al   ; mode 3 / binary

	in      al,port_B
	or      al,3
	out     port_B,al

	mov     ax,1FFFh        ; maximum timer value
AL_loop1:       out     timer_2,al
	mov     al,ah
	out     timer_2,al

	mov     al,10000110b    ; latch channel 2 value
	out     timer_ctrl,al

	mov     al,10110110b    ; read/write word
	out     timer_ctrl,al

	in      al,timer_2
	mov     ah,al
	in      al,timer_2
	xchg    ah,al

	cmp     ax,bx
	jg      al_loop1

	in      al,port_B
	and     al,0FEh
	out     port_B,al

	pop     ax

	ret


Status  equ     331h
Control equ     331h
Data    equ     330h


;       ---------------------------
;       Test if LAPC1 Board Present
;       ---------------------------
;       on exit :
;       al = 1 if present , 0 if not present

TestRoland:     push    cx
	push    dx
	mov     cx,27
TR1:    call    TestRol2
	cmp     al,0FEh
	jz      IsOne           ; LOOPNE wouldn't work here !
	loop    TR1

;       if no acknowledge after this many tries
;       there mustn't be

	pop     dx
	pop     cx
	xor     eax,eax         ; flag no card
	ret

;       Yes , one is connected , Do a Reset

IsOne:  mov     al,0FFh
	call    SendCommand
	pop     dx
	pop     cx
	mov     eax,1
	ret


TestRol2:       push    cx
	mov     dx,status
	mov     cx,-1
tr21:   in      al,dx           ; make sure it isn't busy
	test    al,40h          ; we need to test bit 6
	loopnz  tr21

	mov     al,0FFh         ; Reset Command
	out     dx,al           ; send it

	mov     cx,-1           ; Maximum no of tries
tr22:   in      al,dx
	test    al,80h          ; Bit 7 is Data Strobe ( possibly !)
	loopnz  tr22

	mov     dx,data
	in      al,dx

	pop     cx
	ret                     ; Should be Acknowledge in AL


;       -----------------------------
;       Send a command to the MPU-401
;       -----------------------------

SendCommand:    push    ax
	push    cx
	push    dx
	mov     dx,status
	mov     ah,al           ; keep command byte
sc1:    in      al,dx           ; make sure it isn't busy
	add     al,al           ; we need to test bit 6
	js      sc1             ; here it is in bit 7 - sign flag

	mov     al,ah           ; get command back
	out     dx,al           ; send it

sc2:    in      al,dx
	or      al,al           ; Bit 7 is DSR ( possibly !)
	js      sc2

	mov     dx,data
	in      al,dx

	cmp     al,0FEh         ; 0FEh = acknowledge byte

	pop     dx
	pop     cx
	pop     ax
	ret



;       ---------------------
;       check for Tandy sound
;       ---------------------
;       on exit :
;       al = 1 if present , else 0
;       PortAddress = tandy sound IO port address

;       this routine has been brought to you by Tandy US
;       in PsygnosisVision , thru DMA Design

testtandy:      push    es

	mov     ax,8100h        ; issue a status command to
	int     1Ah             ; the sound BIOS call
	cmp     ah,80h          ; see what the result is
	jc      yesboth         ; BIOS returned a port number

;       mov     ax,0F000h
;       mov     es,ax
;       mov     al,byte ptr es:0C000h

	mov     es,[__x386_zero_base_selector]
	mov     al,es:[0f0000h + 0c000h]

	cmp     al,21h          ; this byte is present on all 1000s
	jz      TIonly

;       the TI sound and digital hardware is not present ,
;       at least on Tandy systems

	xor     eax,eax         ; signal not available
	jmp     TT_exit         ; pull everything and return

;       the TI sound hardware is available but the digital
;       sound hardare is not ( Digital sound not used by this driver anyway )

TIonly: mov     portaddress,0C0h        ; set port address
	mov     al,1                    ; signal soundchip found
	jmp     TT_exit         ; pull everything and return

YesBoth:        sub     ax,4            ; following documentation supplied
	mov     portaddress,ax  ; having dry-run the code !!!
	mov     eax,1

TT_exit:        pop     es
	ret



music_checked:  ;check what boards are present

	test    [_force_roland],-1                      ;has r option been used
	jne     got_r_option

	test    [sblflag2],-1
	jne     got_blaster

got_r_option:   test    [rolandflag2],-1
	jne     got_roland

	test    [adlibflag2],-1
	jne     got_adlib

;       yes we have no boards

	ret

got_roland:     bts     [system_flags],sf_roland
	bts     [system_flags],sf_plus_fx

	mov     [mboard_offset],rl_mboard_offset
	mov     [max_music_size],rl_max_music_size
	mov     [max_fx_size],rl_max_fx_size

	jmp     found_board

got_blaster:    bts     [system_flags],sf_sblaster
	bts     [system_flags],sf_plus_fx

	mov     [max_fx_size],sb_max_fx_size

got_adlib:      bts     [system_flags],sf_adlib

	mov     [mboard_offset],sb_mboard_offset
	mov     [max_music_size],sb_max_music_size


found_board:    bts     [system_flags],sf_music_board


;       allocate space for the driver / music

	push    es

	mov     ebx,[max_music_size]
ifdef mem_check
	add     [dos_mem_allocated],ebx
endif
	shr     ebx,4
	inc     ebx
	mov     ah,48h
	int     21h

	mov     [driver_seg],ax
	mov     [driver_add],ebx

	push    [max_music_size]                                ;lock the data
	push    ds
	push    [driver_add]
	call    __x386_memlock
	cherror eax,ne,0,em_internal_error
	lea     esp,12[esp]


;	allocate space for the fx ROLAND/SBLASTER ONLY

	bt      [system_flags],sf_plus_fx
	jnc     fx_not_valid

	mov     ebx,[max_fx_size]
ifdef mem_check
	add     [dos_mem_allocated],ebx
endif
	shr     ebx,4
	inc     ebx
	mov     ah,48h
	int     21h
	mov     [fx_seg],ax
	mov     [fx_add],ebx

	push    [max_fx_size]                           ;lock the data
	push    ds
	push    [fx_add]
	call    __x386_memlock
	cherror eax,ne,0,em_internal_error
	lea     esp,12[esp]

fx_not_valid:	mov     ax,2509h                                ;get system segments and selectors
	int     21h
	mov     [code16_seg],bx

	movzx   ebx,bx                          ;zero upper word
	shl     ebx,4                           ;make into an absoloute address
	mov     es,__x386_zero_base_selector    ;point to base memory
	assume  es:nothing

	mov     ax,[driver_seg]                 ;store value of code segment
	mov     es:music_bin_seg[ebx],ax

	pop     es

;	On sblaster make a 64k buffer for voc files

;	remember music binary not loaded at this point

	bt      [system_flags],sf_sblaster
	jnc     init_music_ret

	mov     ebx,65536/16
ifdef mem_check
	add     [dos_mem_allocated],65536
endif
	mov     ah,48h
	int     21h
	jnc     qop
	cherror eax,ne,0,em_memory_error
qop:	mov     [voc_work_seg],ax
	mov     [voc_work_space],ebx

	mov     eax,65536                               ;lock the data
	push    eax
	push    ds
	push    [voc_work_space]
	call    __x386_memlock
	cherror eax,ne,0,em_internal_error
	lea     esp,12[esp]

	mov     ah,100                                  ;set up voc segment
	mov     bx,[voc_work_seg]
ifdef debug_42
	and     eax,0ff00h
	clear   ecx
	clear   edx
endif
	call    music_command

	mov     ebx,65536/16
ifdef mem_check
	add     [dos_mem_allocated],65536
endif
	mov     ah,48h
	int     21h
	jnc     qip
	cherror eax,ne,0,em_memory_error
qip:	mov     [voc_fx_seg],ax
	mov     [voc_fx_space],ebx

	mov     eax,65536                               ;lock the data
	push    eax
	push    ds
	push    [voc_fx_space]
	call    __x386_memlock
	cherror eax,ne,0,em_internal_error
	lea     esp,12[esp]

	mov     ah,102                                  ;set up voc segment
	mov     bx,[voc_fx_seg]
ifdef debug_42
	and     eax,0ff00h
	clear   ecx
	clear   edx
endif
	call    music_command

	bts     [system_flags],sf_play_vocs             ;allow speech
	bts     [system_flags],sf_allow_speech

init_music_ret: ret

init_music      endp




load_section_music      proc

;       load music binary file for section eax

	mov     [current_music],0

	bt      [system_flags],sf_music_board                   ;no board, no music
	jnc     load_no_music

	cherror eax,nc,7,em_internal_error

	push    es

;       If binary already loaded then stop any music or fx

	bt      [system_flags],sf_music_bin
	jnc     first_one

	push    eax

	mov     ah,6
	call    music_command
	mov     ah,3
	call    music_command
	mov     ah,1
	call    music_command
	mov     ah,3
	call    music_command

	pop     eax

first_one:	;calculate music file number

	imul    eax,files_per_section
	add     eax,music_base_file
	add     eax,[mboard_offset]

	push    eax

ifdef debug_42
	push    eax
	call    get_file_size
	cmp     eax,[max_music_size]
	jc      msize_ok
	pop     ebx
	printf "music file %d size %d, max size %d",ebx,eax,[max_music_size]
msize_ok:	pop     eax
endif

	mov     edx,[driver_add]                        ;load the driver
	call    load_file

	bts     [system_flags],sf_music_bin     ;flag the driver as present

	clear   ecx
	clear   edx

;	Check if we have a configoration override

	test    [config_file_present],-1
	je      no_cfg

	mov     dl,2[config_name]                       ;get port
	jife    dl,no_cfg                       ;0 = auto detect

	mov     dx,word ptr [offset cfg_ports + edx*2]

	movzx   eax,byte ptr 3[config_name]
	mov     cl,byte ptr [offset cfg_irq + eax]

	mov     al,4[config_name]
	mov     ch,byte ptr [offset cfg_dma + eax]

no_cfg: clear   eax                             ;initialise driver

	call    music_command

	pop     eax

;       Roland and sblaster have seperate fx files

	bt      [system_flags],sf_plus_fx
	jnc     no_fx

	inc     eax

ifdef debug_42
	push    eax
	call    get_file_size
	cherror eax,nc,[max_fx_size],em_internal_error
	pop     eax
endif

	mov     edx,[fx_add]
	call    load_file

	mov     eax,900h
	mov     cx,[fx_seg]
	call    music_command

	mov     ah,100                          ;set up voc segment
	mov     bx,[voc_work_seg]
	call    music_command

	mov     ah,102                          ;set up voc segment
	mov     bx,[voc_fx_seg]
	call    music_command

no_fx:  pop     es

;       set music tempo

	mov     eax,200h
	mov     ecx,23864       ;23000
	call    music_command


load_no_music:  ret

load_section_music      endp




fn_start_fx     proc

;       start sound eax on channel ebx.

	and     bl,1                                    ;only 2 channels, 0 & 1

	cmp     eax,max_fx_number+1
	jnc     num_err
	cmp     eax,256
	jnc     num_ok
num_err:        mov     al,1
	ret

num_ok: cmp     eax,278                                 ;is this weld in room 25
	jne     not_weld_25
	cmp     [screen],25
	jne     not_weld_25
	mov     eax,394

not_weld_25:    mov     [stfx_cur_snd],eax
	mov     [stfx_cur_chn],ebx

	btr     eax,8                                   ;check for special sound

	mov     esi,[offset music_list + eax*4]         ;get pointer to fx info
	mov     edx,[screen]                            ;and current screen

	mov     edi,esi
	lea     edi,2[edi]                              ;point to room list

	cmp     bpt[edi],-1                             ;if room list empty then do all rooms
	je      do_fx

room_loop:      cmp     dl,[edi]                                        ;check rooms
	je      do_fx

	lea     edi,3[edi]
	cmp     bpt[edi],-1
	jne     room_loop

	jmp     no_fx

do_fx:  ;get fx volume

	mov     cl,7fh                                  ;start with max vol

	bt      [system_flags],sf_sblaster
	jc      get_vol
	bt      [system_flags],sf_roland
	jnc     got_vol
	inc     edi
get_vol:        movzx   ecx,bpt 1[edi]                          ;get volume

got_vol:        movzx   eax,bpt [esi]                           ;get sound number

;       Check the flags, the sound may come on after a delay.

	movzx   edx,bpt 1[esi]                          ;get flags

	test    dl,sfxf_start_delay                     ;start delay?
	jne     start_delay

	test    dl,sfxf_save                            ;put into save table?
	je      normal_fx

;       fx needs saving

	mov     esi,[stfx_cur_chn]
	mov     edx,[stfx_cur_snd]
	mov     [offset save_fx_0 + esi*4],edx

	jmp     normal_fx


start_delay:    ;put fx into delay table

	and     dl,7fh

;       Look for a slot

	mov     esi,offset fx_queue
	mov     ch,max_queued_fx

qlook_loop:     test    (queue_fx ptr[esi]).count,-1
	jne     used

;       This queue is free

	mov     (queue_fx ptr[esi]).count,dl
	mov     (queue_fx ptr[esi]).fx_no,al
	mov     (queue_fx ptr[esi]).chan,bl
	mov     (queue_fx ptr[esi]).vol,cl

	;mov    bpt [offset start_delay_count0 + ebx*4],dl
	;mov    bpt 1[offset start_delay_count0 + ebx*4],al
	;mov    bpt 2[offset start_delay_count0 + ebx*4],cl

	mov     al,1
	ret

used:   lea     esi,SIZE queue_fx[esi]
	dec     ch
	jne     qlook_loop

	mov     al,1            ;ignore effect
	ret

normal_fx:      call    start_fx_main

no_fx:  mov     al,1
	ret

fn_start_fx     endp




start_fx_main   proc

;       fx eax, chan ebx, vol ecx

	and     ebx,1

	je      not_ch_0                                        ;play vocs on channel 1

	bt      [system_flags],sf_voc_playing
	jc      no_fx

not_ch_0:       mov     [offset fx_vol_0x + ebx],ecx

	bt      [system_flags],sf_fx_off                        ;fx turned off?
	jc      no_fx

	mov     ah,5
	mov     ch,bl

	call    music_command

no_fx:  ret

start_fx_main   endp




fn_pause_fx     proc

;       Set fx volumes to 0 temporarily

	bt      [system_flags],sf_fx_off
	jc      no_pause

	mov     ah,10
	clear   ecx
	call    music_command

	mov     ah,10
	mov     cx,100h
	call    music_command

no_pause:       mov     al,1
	ret

fn_pause_fx     endp




fn_un_pause_fx  proc

;       Set fx volumes to 0 temporarily

	bt      [system_flags],sf_fx_off
	jc      no_pause

	mov     ah,10
	clear   ch
	mov     cl,[fx_vol_0x]
	call    music_command

	mov     ah,10
	mov     ch,1
	mov     cl,[fx_vol_1x]
	call    music_command

no_pause:       mov     al,1
	ret

fn_un_pause_fx  endp




fx_control      proc

;       Start or stop a delayed fx

	mov     esi,offset fx_queue
	mov     ecx,max_queued_fx

con_loop:       test    (queue_fx ptr[esi]).count,-1            ;slot full?
	je      mt_slot

	dec     (queue_fx ptr[esi]).count                       ;do it yet?
	jne     mt_slot

	push    esi
	push    ecx
	mov     al,(queue_fx ptr[esi]).fx_no
	mov     bl,(queue_fx ptr[esi]).chan
	mov     cl,(queue_fx ptr[esi]).vol
	call    start_fx_main

	pop     ecx
	pop     esi

mt_slot:        lea     esi,SIZE queue_fx[esi]
	loop    con_loop

no_stop:        ret

fx_control      endp


;       fn_stop_fx stops a sound effect on a channel and clears the save_fx status
;       fn_suspend_fx stops the sound but keeps the save status (used by control panel_

fn_stop_fx	proc

;	stop fx on channel eax

	and     eax,1

	mov     dpt[offset save_fx_0 + eax*4],0

	jife    eax,not_0

;	We could be playing a voc file on this channel, don't stop it if we are

	bt      [system_flags],sf_voc_playing
	jc      no_stop_fx

not_0:	;mov    dpt[offset save_fx_0 + eax*4],0
	call    fn_suspend_fx

no_stop_fx:	mov     al,1
	ret

fn_stop_fx	endp



fn_stop_voc	proc

;       When replaying real fast we have to be able to stop voc files

	mov     ah,8
	mov     ch,1
	call    music_command
	btr     [system_flags],sf_voc_playing
	ret

fn_stop_voc     endp



fn_suspend_fx   proc

;       Stop fx on channel al

	mov     ah,8
	mov     ch,al
ifdef debug_42
	and     eax,0ff00h
	clear   ebx
	and     ecx,0ff00h
	clear   edx
endif
	call    music_command
	ret

fn_suspend_fx   endp




fn_start_music  proc

	cmp     eax,[current_music]
	je      no_mus

	mov     [current_music],eax

	bt      [system_flags],sf_mus_off
	jc      no_mus

	jife    al,stop_music

	mov     ah,4
	mov     ecx,256
	call    music_command

	mov     ecx,[music_volume]              ;0-32
	shl     ecx,3                           ;0-256
	mov     ah,13
	call    music_command

no_mus: mov     al,1
	ret

fn_start_music  endp




restart_current_music proc

	bt      [system_flags],sf_mus_off
	jc      no_mus

	mov     eax,[current_music]
	mov     ah,4
	call    music_command

no_mus: ret

restart_current_music endp




restore_saved_effects_0 proc

	mov     eax,[save_fx_0]                 ;check for saved fx on chan 0
	jife    eax,no_sfx_0
	clear   ebx
	call    fn_start_fx

no_sfx_0:       ret

restore_saved_effects_0 endp

restore_saved_effects_1 proc

	mov     eax,[save_fx_1]                 ;check for saved fx on chan 1
	jife    eax,no_sfx_1
	mov     ebx,1
	call    fn_start_fx

no_sfx_1:       ret

restore_saved_effects_1 endp




trash_all_fx    proc

;       Stop any current fx and clear any delayed ones

	clear   eax                             ;Amiga fx stopped on file cache
	call    fn_stop_fx
	mov     eax,1
	call    fn_stop_fx

	mov     esi,offset fx_queue
	mov     ecx,max_queued_fx
trash_loop:     mov     (queue_fx ptr[esi]).count,0
	lea     esi,SIZE queue_fx[esi]
	loop    trash_loop

	ret

trash_all_fx    endp




fn_stop_music   proc

	mov     [current_music],0

fn_stop_music   endp
stop_music      proc

	mov     ah,7
ifdef debug_42
	and     eax,0ff00h
	clear   ebx
	clear   ecx
	clear   edx
endif
	call    music_command

	mov     al,1
	ret

stop_music      endp


end32code


start16code
	extrn   music_bin_seg:word
end16code


	end
