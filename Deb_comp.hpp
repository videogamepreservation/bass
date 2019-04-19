



struct st_compact

{
#define C_LOGIC		0
	int	c_logic;

#define C_STATUS	2
	int	c_status;

#define C_SYNC		4
	int	c_sync;

#define C_SCREEN	6
	int	c_screen;

#define C_PLACE		8
	int	c_place;

#define C_GET_TO_TABLE	10
	char *	c_get_to_table;

#define C_XCOOD		14
	int	c_xcood;

#define C_YCOOD		16
	int	c_ycood;

#define C_FRAME		18
	int	c_frame;

#define C_ACTION_SCRIPT	36

#define C_UP_FLAG	38
	int	c_up_flag;

#define C_DOWN_FLAG	40
	int	c_down_flag;

#define C_GET_TO_FLAG	42
	int	c_get_to_flag;

#define C_FLAG		44
	int	c_flag;

#define C_GRAFIX_PROG	48
	int	c_grafix_prog;

#define C_OFFSET	52
	int	c_offset;

#define C_MODE		54
	int	c_mode;

#define C_BASE_SUB	56
	int	c_base_sub;
	int	c_base_sub_off;

#define C_ACTION_SUB	60
	int	c_action_sub;
	int	c_action_sub_off;

#define C_GET_TO_SUB	64
	int	c_get_to_sub;
	int	c_get_to_sub_off;

#define C_EXTRA_SUB	68
	int	c_extra_sub;
	int	c_extra_sub_off;

#define C_DIR		72
	int	c_dir;

#define C_REQUEST	86
	int	c_request;

#define C_SP_COL	90
	int	c_sp_col;

#define C_SP_TEXT_ID	92
	int	c_sp_text_id;

#define C_WAITING_FOR	102
	int	c_waiting_for;

#define C_ANIM_SCRATCH	108
	int	c_anim_scratch;

#define C_MEGA_SET	112
	int	c_mega_set;

};
