#include <stdio.h>
#include <stdlib.h>
#include <process.h>
#include <conio.h>
#include <fcntl.h>
#include <io.h>
#include <string.h>
#include <stdarg.h>
#include <sys\stat.h>


//#define DONT_DISABLE_FAULTS
//#define DEBUG_C
//#define WITH_REPLAY
//#define CMD_OPTIONS
//#define WITH_VOC_EDITOR
//#define FILE_ORDER_CHK
//#define CLICKING_OPTIONAL
//#define AR_DEBUG


int     get_free_disk_space(int);
int     get_current_disk_drive(void);


//      IMPORTANT : These values must be matched in include.asm

#define ENGLISH_CODE    0
#define GERMAN_CODE     1
#define FRENCH_CODE     2
#define USA_CODE        3
#define SWEDISH_CODE    4
#define ITALIAN_CODE    5
#define PORTUGUESE_CODE 6
#define SPANISH_CODE    7

#define START_UP_LANGUAGE       ENGLISH_CODE


#ifdef DEBUG_C

void debug_printf(char *format,...);
void draw_box(char,int,int,int,int);
int     mgetch(void);

struct st_compact_item
{       int     section;
	int     number;
	char *  name;
	int     range;
};

#endif

void pc_restore();

