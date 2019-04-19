;               Welcome to game 2!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

ifdef include_version_info

current_version_text    equ     "Version 0."
current_version_text2   equ     "0372",0


fp1     equ     'V'
fp2     equ     'i'
fp3     equ     'r'
fp4     equ     'g'
fp5     equ     'i'
fp6     equ     'n'
fp7     equ     '.'
fp8     equ     ' '
fp9     equ     ' '
fp10    equ     ' '
fp11    equ     ' '
fp12    equ     ' '
fp13    equ     ' '
fp14    equ     ' '
fp15    equ     ' '
fp16    equ     ' '
fp17    equ     ' '

endif

	include c:\x32vm\include\mac32.asm
ifdef include_macros
	include macros.asm
endif
ifdef include_struc
	include struc.asm
endif
ifdef include_scripts
	include script.equ
endif

;--------------------------------------------------------------------------------------------------conditional assembly equates
;final_version	equ    1			;Set to prevent startup comments
;save_restart_file	equ    1			;when set save restart data
;cd_version_prot	equ	1			;disable protection on cd version
;american_cd	equ	1
;with_screen_saver	equ	1
;italian_set	equ	1			;when set force italian language
;spanish_set	equ	1			;when set force spanish language
;no_timer	equ    1			;when set timer interrupt removed
;no_music	equ    1			;music enabled when set
;no_keyboard	equ    1			;redirect keyboard if set
;mem_check	equ    1			;set for memory allocation check
;s1_demo	equ    1			;set for section 1 demos
;language_testing	equ    1
;dont_check_rlnd	equ    1			;Dont check roland card (speeds up loading)
;do_text_dump	equ    1			;when set dump out what we think the text messages are
;ignore_mouse	equ    1
;short_intro_start	equ    1
;selective_intro	equ    1			;when set don't do all intros
;intro_halt	equ    1			;allow intro to be halted

;       these also defined in deb_inc.hpp

;debug_42	equ     1
;with_replay	equ     1
;cmd_options	equ     1
;with_voc_editor	equ     1			;include voc editor when set
;file_order_chk	equ     1			;when set display files in order of loading (to speed up search times)
;clicking_optional	equ     1			;When set clicking text must be chosen
;ar_debug	equ     1			;When set debug auto route


ifdef include_language_codes

;       IMPORTANT : These values must be matched in include.hpp

english_code	equ     0
german_code	equ     1
french_code	equ     2
usa_code	equ     3
swe_code	equ     4
iti_code	equ     5
por_code	equ     6
spa_code	equ     7

endif

ifdef include_flags
	include flags.asm
endif
	include globals.asm
ifdef include_files
	include files.asm
endif
ifdef include_deb_mac
	include deb_mac.asm
endif

key_buffer_size equ     80                      ;max keys to hold

sequence_count  equ     3

;--------------------------------------------------------------------------------------------------

;       characters with own colour set

sp_col_foster   equ     194
sp_col_joey     equ     216
sp_col_jobs     equ     209
sp_col_so       equ     218
sp_col_holo     equ     234
sp_col_lamb     equ     203
sp_col_foreman  equ     205
sp_col_shades   equ     217
sp_col_monitor  equ     224
sp_col_wreck    equ     219     ;wreck guard
sp_col_anita    equ     73
sp_col_dad      equ     224
sp_col_son      equ     223
sp_col_galag    equ     194
sp_col_anchor   equ     85      ;194
sp_col_burke    equ     192
sp_col_body     equ     234
sp_col_medi     equ     235
sp_col_skorl    equ     241     ;skorl guard    will probably go
sp_col_android2 equ     222
sp_col_android3 equ     222
sp_col_ken      equ     222
sp_col_henri30  equ     128     ;207
sp_col_guard31  equ     216
sp_dan_col      equ     228
sp_col_buzzer32 equ     228     ;124
sp_col_vincent32        equ     193
sp_col_gardener32       equ     145
sp_col_witness  equ     195
sp_col_jobs82   equ     209
sp_col_ken81    equ     224
sp_col_father81 equ     177
sp_col_trevor   equ     216
sp_col_radman   equ     193
sp_col_barman36 equ     144
sp_col_babs36   equ     202
sp_col_gallagher36      equ     145
sp_col_colston36        equ     146
sp_col_jukebox36        equ     176
sp_col_judge42  equ     193
sp_col_clerk42  equ     195
sp_col_pros42   equ     217
sp_col_jobs42   equ     209

sp_col_hologram_b       equ     255
sp_col_blue     equ     255
sp_col_loader   equ     255

sp_col_uchar    equ     255

;--------------------------------------------------------------------------------------------------

first_text_compact      equ     23

main_char_height        equ     12                      ;height of main character set

;--------------------------------------------------------------------------------------------------error equates

ifdef include_error_codes

em_internal_error               equ     0                       ;hodge podge of errors, mostly debugging
em_game_over            equ     1                       ;Message after quit to dos
em_no_vga               equ     2                       ;VGA card not found
em_inv_dos              equ     3                       ;DOS version too early (on a 386??!)
em_no_dnr_file          equ     4                       ;sky.dnr not found
em_disk_rd_error		equ     5                       ;error reading or writing to disk
em_no_dsk_file		equ     6                       ;sky.dsk not found
em_memory_error		equ     7                       ;Ran out of memory
em_dnr_file		equ     8                       ;Dodgy sky.dnr
em_invalid_save		equ     9                       ;Invalid save game
em_no_mouse		equ     10                      ;Mouse not found

endif

;--------------------------------------------------------------------------------------------------amiga->pc equates

$000            equ     0
$42             equ     042h
$a6             equ     0a6h
$aa             equ     0aah
$ab             equ     0abh
$ac             equ     0ach
$af             equ     0afh
$b0             equ     0b0h
$b1             equ     0b1h
$b2             equ     0b2h
$b3             equ     0b3h
$b5             equ     0b5h
$bf             equ     0bfh
$c1             equ     0c1h
$c2             equ     0c2h
$c3             equ     0c3h
$c4             equ     0c4h
$c5             equ     0c5h
$c9             equ     0c9h
$cf             equ     0cfh
$bb             equ     0bbh
$be             equ     0beh
$d2             equ     0d2h
$de             equ     0deh
$df             equ     0dfh
$e1             equ     0e1h
$e5             equ     0e5h
$e6             equ     0e6h
$ec             equ     0ech
$ee             equ     0eeh
$ef             equ     0efh
$f0             equ     0f0h
$f1             equ     0f1h
$f2             equ     0f2h
$f5             equ     0f5h
$fa             equ     0fah
$fb             equ     0fbh
$ff             equ     0ffh
$10e            equ     10eh
$119            equ     119h
$11f            equ     11fh
$120            equ     120h
$123            equ     123h
$146            equ     146h
$14b            equ     14bh
$14c            equ     14ch
$156            equ     156h
$157            equ     157h
$18e            equ     18eh
$1a2            equ     1a2h
$bbb            equ     0bbbh
$f48            equ     0f48h
$8000      equ  8000h
$ffff      equ  0ffffh
NULL            equ     ?


;--------------------------------------------------------------------------------------------------screen/grid equates

game_screen_width               equ     320
game_screen_height              equ     192
full_screen_width               equ     320
full_screen_height              equ     200

tot_no_grids            equ     70              ;no of grids supported

grid_size               equ     120             ;size of a grid in bytes

GRID_X    equ   20              ;number of blocks accross
GRID_Y    equ   24              ;number of blocks high
GRID_W    equ   16
GRID_H    equ   8

GRID_W_SHIFT            equ     4
GRID_H_SHIFT            equ     3

top_left_x              equ     128
top_left_y              equ     136

;--------------------------------------------------------------------------------------------------item list equates

section_0_item    equ   119             ;item number of first item section

ifdef include_sequates

;       Item list equates

;it_next         equ    4               ;Size of an item list entry
;it_next_shift     equ  2               ;shift multiplier


sequate	macro num

s&num	equ	(&num * 64)

endm


	sequate 12
	sequate 13
	sequate 14
	sequate 15
	sequate 16
	sequate 17
	sequate 18
	sequate 19
	sequate 20
	sequate 21
	sequate 22
	sequate 23
	sequate 24
	sequate 25
	sequate 26
	sequate 27
	sequate 28
	sequate 29
	sequate 30
	sequate 31
	sequate 32
	sequate 33
	sequate 34
	sequate 35
	sequate 36
	sequate 37
	sequate 38
	sequate 39
	sequate 40
	sequate 41
	sequate 42
	sequate 43
	sequate 44
	sequate 45
	sequate 46
	sequate 47
	sequate 48
	sequate 49
	sequate 50
	sequate 51
	sequate 52
	sequate 53
	sequate 54
	sequate 55
	sequate 56
	sequate 57
	sequate 58
	sequate 59
	sequate 60
	sequate 61
	sequate 62
	sequate 63
	sequate 64
	sequate 65
	sequate 66
	sequate 67
	sequate 68
	sequate 69
	sequate 70
	sequate 71
	sequate 72
	sequate 73
	sequate 74
	sequate 75
	sequate 76
	sequate 85
	sequate 86
	sequate 87
	sequate 88
	sequate 89
	sequate 90
	sequate 91
	sequate 92
	sequate 93
	sequate 95
	sequate 96
	sequate 97
	sequate 98
	sequate 99
	sequate 100
	sequate 101
	sequate 102
	sequate 103
	sequate 104
	sequate 105
	sequate 106
	sequate 107
	sequate 108
	sequate 109
	sequate 110
	sequate 111
	sequate 112
	sequate 113
	sequate 114
	sequate 115
	sequate 116
	sequate 117
	sequate 119
	sequate 120
	sequate 129
	sequate 130
	sequate 131
	sequate 132
	sequate 133
	sequate 134
	sequate 135
	sequate 136
	sequate 137
	sequate 138
	sequate 139
	sequate 140
	sequate 141
	sequate 142
	sequate 143
	sequate 144
	sequate 145
	sequate 146
	sequate 147
	sequate 148
	sequate 149
	sequate 150
	sequate 151
	sequate 152
	sequate 153
	sequate 154
	sequate 155
	sequate 156
	sequate 157
	sequate 158
	sequate 159
	sequate 160
	sequate 161
	sequate 162
	sequate 163
	sequate 164
	sequate 165
	sequate 166
	sequate 167
	sequate 168
	sequate 169
	sequate 170
	sequate 171
	sequate 172
	sequate 173
	sequate 174
	sequate 175
	sequate 176
	sequate 177
	sequate 178
	sequate 179
	sequate 180
	sequate 181
	sequate 183
	sequate 184
	sequate 185
	sequate 186
	sequate 187
	sequate 188
	sequate 189
	sequate 190
	sequate 192
	sequate 193
	sequate 194
	sequate 195
	sequate 196
	sequate 197
	sequate 198
	sequate 199
	sequate 200
	sequate 201
	sequate 202
	sequate 203
	sequate 204
	sequate 205
	sequate 206
	sequate 207
	sequate 208
	sequate 209
	sequate 210
	sequate 211
	sequate 212
	sequate 213
	sequate 214
	sequate 215
	sequate 216
	sequate 217
	sequate 218
	sequate 219
	sequate 220
	sequate 224
	sequate 225
	sequate 226
	sequate 227
	sequate 228
	sequate 229
	sequate 231
	sequate 232
	sequate 258
	sequate 259
	sequate 260
	sequate 261
	sequate 262
	sequate 263
	sequate 264
	sequate 265
	sequate 266
	sequate 267
	sequate 268
	sequate 269
	sequate 270
	sequate 271
	sequate 272
	sequate 273
	sequate 274
	sequate 275
	sequate 276
	sequate 277
	sequate 278
	sequate 279
	sequate 280
	sequate 281
	sequate 282
	sequate 283
	sequate 284

endif

c_base_mode             equ     0               ;base value of c_mode
c_base_mode56      equ  56              ;base value of c_mode
c_action_mode      equ  4               ;base value of action mode
c_sp_colour             equ     90
c_mega_set              equ     112
c_grid_width            equ     114

next_mega_set      equ  (SIZE compact - c_grid_width)

send_sync               equ     (-1)            ;alter with care
lf_start_fx             equ     (-2)

safe_start_screen               equ     0

;--------------------------------------------------------------------------------------------------autoroute equates

upy     equ     0
downy   equ     1
lefty   equ     2       ;autoroute direction markers
righty  equ     3

route_space     equ     64                              ;space for final route, 16 sets of movements


;--------------------------------------------------------------------------------------------------

ifdef include_keyboard_codes

ifdef no_keyboard

key_f5  equ     13fh

key_alt_1       equ     178h
key_alt_2       equ     179h
key_alt_3       equ     17ah

else

key_f5  equ     132

key_alt_1       equ     141
key_alt_2       equ     142
key_alt_3       equ     143

endif

key_delete      equ     127

key_f1  equ     128
key_f2  equ     129
key_f3  equ     130
key_f4  equ     131

key_f6  equ     133
key_f7  equ     134
key_f8  equ     135
key_f9  equ     136
key_f10 equ     137
key_f11 equ     138
key_f12 equ     139

key_scroll_lock equ     140

endif

pconly_f_r3_1   equ     0
pconly_f_r3_2   equ     0
;chutney_speech equ     0

restart_butt_x  equ     147
restart_butt_y  equ     309
restore_butt_x  equ     246
restore_butt_y  equ     309
exit_butt_x     equ     345
exit_butt_y     equ     309


ifdef include_logic

;	logic

l_script	equ	1
l_ar	equ	2
l_ar_anim	equ	3
l_ar_turning	equ	4
l_alt	equ	5
l_mod_animate	equ	6
l_turning	equ	7
l_cursor	equ	8
l_talk	equ	9
l_listen	equ	10
l_stopped	equ	11
l_choose	equ	12
l_frames	equ	13
l_pause	equ	14
l_wait_sync	equ	15
l_simple_mod	equ	16

endif
