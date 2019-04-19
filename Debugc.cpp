#include "include.hpp"
#include "deb_comp.hpp"

#ifdef DEBUG_C

int	debug_flag=0;

/*	A hugely complicated debug routine		*/

#define ITEM_SECTIONS 7

int open_for_write(char *);

st_compact_item compact_items[] = {	{0,1,"joey",C_MEGA_SET},
					{0,3,"foster",C_MEGA_SET},
					{0,16,"lamb",C_MEGA_SET},
					{0,23,"Text 1",C_FLAG},
					{0,44,"Talk 1",C_MEGA_SET},
					{0,45,"Talk 2",C_MEGA_SET},
					{0,46,"menu bar",C_FRAME},
					{0,47,"left_arrow",C_MEGA_SET},
					{0,66,"joeyb_menu",C_MEGA_SET},
					{0,67,"low_floor",C_MEGA_SET},
					{0,69,"stairs",C_MEGA_SET},
					{0,85,"bar",C_ACTION_SCRIPT},
					{0,90,"door",C_ACTION_SCRIPT},
					{0,105,"small_door",C_ACTION_SCRIPT},
					{0,111,"right_exit0",C_ACTION_SCRIPT},
					{0,122,"cancel_button",C_MEGA_SET},
					{0,136,"monitor 9",C_MEGA_SET},
					{1,4,"Mini_so",C_MEGA_SET},
					{1,6,"fan1",C_BASE_SUB},
					{1,15,"lazer",C_BASE_SUB},
					{1,20,"top_lift",C_ACTION_SCRIPT},
					{1,22,"liftbit",C_ACTION_SCRIPT},
					{1,23,"hole",C_ACTION_SCRIPT},
					{1,24,"top_barrel",C_ACTION_SCRIPT},
					{1,25,"loader",C_ACTION_SCRIPT},
					{1,26,"Jobsworth",C_MEGA_SET},
					{1,31,"panel",C_BASE_SUB},
					{1,32,"alarm_flash",C_BASE_SUB},
					{1,37,"dead_loader",C_BASE_SUB},
					{1,42,"steve_watch",C_BASE_SUB},
					{1,85,"screen0_low_logic",C_MEGA_SET},
					{1,207,"fan2",C_BASE_SUB},
					{1,209,"fan3",C_BASE_SUB},
					{1,211,"fan4",C_BASE_SUB},
					{1,213,"fan5",C_BASE_SUB},
					{1,215,"fan6",C_BASE_SUB},
					{1,217,"fan7",C_BASE_SUB},
					{1,225,"press",C_MEGA_SET},
					{2,19,"son 9",C_BASE_SUB},
					{2,100,"fans 9",0},
					{2,106,"scanner 9",C_BASE_SUB},
					{2,109,"dad 9",C_MEGA_SET},
					{2,117,"skorl_guard",C_MEGA_SET},
					{2,185,"anita",C_MEGA_SET},
					{2,193,"anita_spy",C_MEGA_SET},
					{3,93,"helga",C_ACTION_SCRIPT},
					{3,119,"burke",C_MEGA_SET},
					{4,57,"danielle",C_MEGA_SET},
					{5,332,"galagher",C_MEGA_SET},
					{0,0,"",0}
				};

char *logic_list[] = {	"return","l_script","l_ar","l_ar_anim","(none)","l_alt","l_anim","l_turning","(none)",
			"l_talk","l_listen","(none)","(none)","l_frames","l_pause","l_wait_sync","l_simple_anim",
			"(none)","(none)","(none)"};

char * fetch_item_section(int);
int	initialise_file(void);
void	out(char *format,...);

int file=0,entry_count=0;

void debug_compact(char *compact_esi,char *message,char *compact_to_debug)
{
char *section;
int count,section_no,item_no,found;
st_compact compact;

if (initialise_file() < 0)
	return;

if ((int)(compact_to_debug))
	if (compact_to_debug!=compact_esi)
		return;

/*	List out the details of the current compact		*/

/*	First find out the name and number of this compact	*/

found=0;
for (section_no=0;(section_no<ITEM_SECTIONS)&&(!found);)

{	char *pointer;
	section=pointer=fetch_item_section(section_no);

	for (item_no=0;(*((int *)pointer)!=0x12345678)&&(!found)&&(item_no<1000);pointer+=4)
		if (*((int *)pointer)==(int)compact_esi)
			found=1;
		else	item_no++;

	if (!found)
		section_no++;
}

for (found=count=0;(found==0)&&(compact_items[count].name[0]);)
{	if ((compact_items[count].section==section_no) && (compact_items[count].number==item_no))
		found=1;
	else	count++;
}

if (!compact_items[count].name[0])
	out("**????????**  (%s), address %x section %d entry %d ---> entry %d\r\n",message,compact_esi,
											section_no,item_no,entry_count++);

else
{	if (compact_items[count].range == 0)
		return;
	out("**%s**  (%s), address %x section %d entry %d ---> entry %d\r\n",compact_items[count].name,message,compact_esi,
											section_no,item_no,entry_count++);
}

/*	Convert the compact to an internal c structure		*/

compact.c_logic=*((short *)(compact_esi+C_LOGIC));
compact.c_status=*((short *)(compact_esi+C_STATUS));
compact.c_sync=*((short *)(compact_esi+C_SYNC));
compact.c_screen=*((short *)(compact_esi+C_SCREEN));
compact.c_place=*((short *)(compact_esi+C_PLACE));
compact.c_get_to_table=(char *) *((int *)(compact_esi+C_GET_TO_TABLE));
compact.c_xcood=*((short *)(compact_esi+C_XCOOD));
compact.c_ycood=*((short *)(compact_esi+C_YCOOD));
compact.c_frame=*((short *)(compact_esi+C_FRAME));
compact.c_up_flag=*((short *)(compact_esi+C_UP_FLAG));
compact.c_down_flag=*((short *)(compact_esi+C_DOWN_FLAG));
compact.c_get_to_flag=*((short *)(compact_esi+C_GET_TO_FLAG));
compact.c_flag=*((short *)(compact_esi+C_FLAG));
compact.c_grafix_prog=*((int *)(compact_esi+C_GRAFIX_PROG));
compact.c_offset=*((short *)(compact_esi+C_OFFSET));
compact.c_mode = *((short *)(compact_esi+C_MODE));
compact.c_base_sub = *((short *)(compact_esi+C_BASE_SUB));
compact.c_base_sub_off = *((short *)(compact_esi+C_BASE_SUB+2));
compact.c_action_sub = *((short *)(compact_esi+C_ACTION_SUB));
compact.c_action_sub_off = *((short *)(compact_esi+C_ACTION_SUB+2));
compact.c_get_to_sub = *((short *)(compact_esi+C_GET_TO_SUB));
compact.c_get_to_sub_off = *((short *)(compact_esi+C_GET_TO_SUB+2));
compact.c_extra_sub = *((short *)(compact_esi+C_EXTRA_SUB));
compact.c_extra_sub_off = *((short *)(compact_esi+C_EXTRA_SUB+2));
compact.c_dir = *((short *)(compact_esi+C_DIR));
compact.c_request = *((short *)(compact_esi+C_REQUEST));
compact.c_sp_col = *((short *)(compact_esi+C_SP_COL));
compact.c_sp_text_id = *((short *)(compact_esi+C_SP_TEXT_ID));
compact.c_waiting_for = *((short *)(compact_esi+C_WAITING_FOR));
compact.c_anim_scratch = *((int *)(compact_esi+C_ANIM_SCRATCH));
compact.c_mega_set = *((short *)(compact_esi+C_MEGA_SET));


//if (compact.c_logic == 14) // l_pause
//	out("logic\t\t%s (%d)\r\n",logic_list[compact.c_logic],compact.c_flag);
//else	out("logic\t\t%s\r\n",logic_list[compact.c_logic]);

//out("status\t\t%x\r\n",compact.c_status);
//out("sync\t\t%x\r\n",compact.c_sync);
//out("c_screen\t%d\r\n",compact.c_screen);
out("c_place\t\t%d\r\n",compact.c_place);
//out("get_to_table\t%x\r\n",compact.c_get_to_table);
out("Coords\t\t%d,%d (%d,%d)\r\n",compact.c_xcood,compact.c_ycood,compact.c_xcood-128,compact.c_ycood-136);
//out("Frame\t\t%d (set %d)\r\n",compact.c_frame&63,compact.c_frame>>6);

if (compact_items[count].range>C_ACTION_SCRIPT)
{	//out("Up flag\t\t%d\r\n",compact.c_up_flag);
	//out("Down flag\t%d\r\n",compact.c_down_flag);
	//out("Get to flag\t%d\r\n",compact.c_get_to_flag);
	//out("Flag\t\t%d\r\n",compact.c_flag);
}
if (compact_items[count].range>C_FLAG)
{	//out("Offset\t\t%d (set %d)\r\n",compact.c_offset,compact.c_offset>>6);
	//out("Grafix prog\t%x",compact.c_grafix_prog);
	//out(" (%x) ",compact.c_grafix_prog?*((short *)(compact.c_grafix_prog)):0);
	//out(" (%x)\r\n",compact.c_grafix_prog?*((short *)(compact.c_grafix_prog+2)):0);
	out("mode\t\t%d\r\n",compact.c_mode);
	out("base sub\t%.4x (%.4x)\r\n",compact.c_base_sub,compact.c_base_sub_off);
}
if (compact_items[count].range>C_BASE_SUB)
{	out("action sub\t%.4x (%.4x)\r\n",compact.c_action_sub,compact.c_action_sub_off);
	out("get to sub\t%.4x (%.4x)\r\n",compact.c_get_to_sub,compact.c_get_to_sub_off);
	//out("extra sub\t%.4x (%.4x)\r\n",compact.c_extra_sub,compact.c_extra_sub_off);
	//out("Dir\t\t%x\r\n",compact.c_dir);
	//out("Request\t\t%x\r\n",compact.c_request);
	//out("Col\t\t%x\r\n",compact.c_sp_col);
	//out("Speech text id\t%x\r\n",compact.c_sp_text_id);
	//out("Waiting for\t%x\r\n",compact.c_waiting_for);
	//out("Anim scratch\t%x\r\n",compact.c_anim_scratch);
	//out("Mega set\t%x\r\n",compact.c_mega_set);
}

out("\r\n-------------------------------------------------------------\r\n");
}


int initialise_file()
{
char dfname[200];

if (debug_flag >= 0)	//	if top bit clear, don't write anything. Bit 31 set after announces made
	return(-1);		//	This stops debug files being made when sky game run by mistake


if (!file)
{	unlink(".\\debug");
	file =  open_for_write(".\\debug");
	if (file<0)
		debug_flag &= 0x7ffffff;
}
return(1);
}


void out(char *format,...)
{
va_list arg_ptr;
char buffer[200];
va_start(arg_ptr,format);

vsprintf(buffer,format,arg_ptr);
write(file,buffer,strlen(buffer));
flushall();
}



void debug_printf(char *format,...)
{
va_list arg_ptr;
char buffer[200];
va_start(arg_ptr,format);
vsprintf(buffer,format,arg_ptr);

if (initialise_file() < 0)
	return;

write(file,buffer,strlen(buffer));
write(file,"\r\n",2);
flushall();
}


#define GRID_W		42
#define GRID_H		26
#define BLOCK_SIZE	5


//extern int debug_flag;


void dump_file(char *name,char *data,int len)
{
int file;

file = open(name,O_WRONLY|O_CREAT|O_TRUNC,0666);
write(file,data,len);
close(file);

}


//void voc_chick_file(int number,char * addr,int size)
//{
//
//char buffer[20];
//
//sprintf(buffer,"vocchick.%d",number);
//
//int file = open(buffer,O_WRONLY|O_CREAT|O_TRUNC,0666);
//if (file<0)
//{	printf("guuuuurgggh\r\n");
//	exit(22);
//}
//write(file,addr,size);
//close(file);
//
//}


#endif


//;--------------------------------------------------------------------------------------------------


#ifdef FILE_ORDER_CHK

#define DONT_SHOW_ALL				//	When not set, show all loaded files (for sorting)
							//	When set show jump files (checking)

//#define JUST_LOADERS				//	show just what we are loading

//	Show what files are loaded and in what order

int *loaded_list = NULL;
int max_loaded_file;
int file_position = 0;
int current_file=0,last_file,on_room_change = 0,current_game_room = 0,next_file_is_repeatable = 0,repeated_file;

char *file_with_set(int);

void this_file_loaded(int file)
{
int count;

debug_printf("Load %s",file_with_set(file));

last_file = current_file;
current_file = file;

if (on_room_change)
	debug_printf("*>Room change to %d with file %s",current_game_room,file_with_set(file));

if (loaded_list)
{	if (file >= max_loaded_file)
	{	loaded_list = realloc(loaded_list,(file+1)*sizeof(int));
		for (count = max_loaded_file; count <= file; count++)
			loaded_list[count] = 0;
		max_loaded_file = file;
	}
}
else
{	loaded_list = malloc((file+1)*sizeof(int));
	for (count = 0; count <= file; count++)
		loaded_list[count] = 0;
	max_loaded_file = file;
}

switch(loaded_list[file])

{	case 0:
		loaded_list[file] = 1;
		repeated_file = 0;
		break;

	case 1:
		if (!next_file_is_repeatable)
			if ( (current_file < 60000) || (current_file > 60069) )	//	Grids are often reloaded
				debug_printf("Repeated file %s",file_with_set(current_file));
		loaded_list[file] = 2;

//		no break;

	default:
		repeated_file = 1;
		break;

}

next_file_is_repeatable = 0;

}

void position_file(int new_position)
{

//	Game is lseeking

//	Show up file if a jump is necessary or if we haven't sorted the files

#ifndef JUST_LOADERS

#ifdef DONT_SHOW_ALL
if (new_position != file_position)
#endif

//	Repeated files have been mentioned elsewhere

{	if ( (!on_room_change) && (!repeated_file) )
		debug_printf("Move : %s (after %s)",
			file_with_set(current_file),file_with_set(last_file));

	file_position = new_position;
}

#endif

on_room_change = 0;

}

void load_file_data(int size)
{
//	game is loading file

file_position += size;

}

void lseek_allowed(int new_room)	//	lseek allowed on room changes
{

current_game_room = new_room;
on_room_change = 1;

}

void next_file_repeatable()
{

next_file_is_repeatable = 1;

}


char *file_with_set(int file)
{
static char fred1[20];
static char fred2[20];
static int char_switch = 0;
char *jon;

if (char_switch)
	jon = fred1;
else	jon = fred2;

char_switch = 1-char_switch;

if (file < 50000)
	sprintf(jon,"%d,%d",file/2048,file%2048);
else	sprintf(jon,"%d",file);

return(jon);

}


#endif

