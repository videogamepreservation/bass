#include <stdio.h>
#include <stdlib.h>
#include <direct.h>
#include <process.h>
#include "include.hpp"
#include <x32.h>

void check_disk_drive(void);
void decode_argv_1(int args,char **arglist);
void decode_argv_2(int args,char **arglist);
void _cdecl handler(struct FAULT_STRUC *fault);
void kill_mouse(void);
void initialise(void);
void intro(void);
void mainloop(void);
void load_config(void);

int	force_roland = 0;				//	set this to force roland
int	do_a_replay=0;
int	force_sounds_off=0;				//	Set this to prevent music drivers from being loaded
int	cd_version = 0;
int	skip_intro=0;
int	start_flag2=0;

//extern char * _envptr;

#ifdef CLICKING_OPTIONAL
int	allow_clicking=0;
#endif

int	language = START_UP_LANGUAGE;

#ifdef CMD_OPTIONS
int	start_flagznotused=0;
int	ignore_saved_game_version=0;
#endif

main(int argc,char **argv)
{

#ifndef DONT_DISABLE_FAULTS
_x32_fault_intercept(handler);
#endif

decode_argv_1(argc-1,argv+1);
load_config();

#ifdef DEBUG_C

switch(language)
{	case ENGLISH_CODE:
		printf("English\n");
		break;

	case GERMAN_CODE:
		printf("German\n");
		break;

	case FRENCH_CODE:
		printf("French\n");
		break;

	case USA_CODE:
		printf("American\n");
		break;

	case SWEDISH_CODE:
		printf("Swedish\n");
		break;

	case ITALIAN_CODE:
		printf("Italian\n");
		break;

	case PORTUGUESE_CODE:
		printf("Portuguese\n");
		break;

	case SPANISH_CODE:
		printf("Spanish\n");
		break;

	default:
		printf("Invalid language\n");
		exit(1);
}

#endif

decode_argv_2(argc-1,argv+1);

check_disk_drive();			//	This comes before initialise in case there is an error in initialise

initialise();

#ifdef CMD_OPTIONS
if (start_flag == 0)
#endif
	intro();

mainloop();

return(0);

}

void _cdecl handler(struct FAULT_STRUC *fault)
{
	pc_restore();

	switch(language)
	{	case ENGLISH_CODE:
		case USA_CODE:
			printf("Fatal System Error\n");
			break;

		case GERMAN_CODE:
			printf("Fatal System Error\n");
			break;

		case FRENCH_CODE:
			printf("Erreur syst確e fatale\n");
			break;

		case SWEDISH_CODE:
			printf("Erreur syst確e fatale\n");
			break;

		case ITALIAN_CODE:
			printf("Erreur syst確e fatale\n");
			break;

		case PORTUGUESE_CODE:
			printf("Erro Fatal do Sistema\n");
			break;

		case SPANISH_CODE:
			printf("Erreur syst確e fatale\n");
			break;
	}

	printf("cs:eip =  %x:%x\n",(int)(*fault).cs,(*fault).eip);
	printf("Sorry!\n");

//  pzrintf("\nFault # %d has been intercepted.",(int)(*fault).fault_num);
//  pzrintf("\n\neax = %.8xH  ebx = %.8xH  ecx = %.8xH  edx = %.8xH",
//    (*fault).eax,(*fault).ebx,(*fault).ecx,(*fault).edx);
//  pzrintf("\n\nedi = %.8xH  esi = %.8xH  ebp = %.8xH",
//    (*fault).edi,(*fault).esi,(*fault).ebp); 
//  pzrintf("\n\nds = %.4xH  es = %.4xH  fs = %.4xH  gs = %.4xH",
//    (int)(*fault).ds,(int)(*fault).es,(int)(*fault).fs,(int)(*fault).gs);
//  pzrintf("\n\nss:esp = %.4x:%.8xH",(int)(*fault).ss,(*fault).esp);
//  pzrintf("\n\ncs:eip = %.4x:%.8xH",(int)(*fault).cs,(*fault).eip);

	exit(1);              /* Exit with error code.                */
}

char *file_start="";
char *file_name;


void decode_argv_1(int args,char **arglist)
{

static int helpy=0;

file_name = malloc(30);

while (args)

{	char *line = *arglist;

	if (*line == 'z')
		helpy = 1;

	if (strncmp(line,"CFG=",4)==0)
	{	file_start = malloc(strlen(line));
		strcpy(file_start,line+4);
		strcpy(file_start+strlen(file_start),"\\");

		if (helpy)
		{	printf("\r\ncfg := %s\r\n\r\n",file_start);
			exit(1);
		}
	}

	args--;
	arglist++;
}
}

void decode_argv_2(int args,char **arglist)
{

while (args)

{	char *line = *arglist;

	if (strncmp(line,"start",5)==0)
	{	//	We want to start on a new section
		start_flag2 = line[5] - '0';
		if ( (start_flag2 < 2) || (start_flag2 > 9) )
			exit(1);
		skip_intro = 1;
	}

	else	if (strncmp(line,"CFG=",4)==0) {}

	while (*line)

	{
#ifdef CMD_OPTIONS
		if ( (*line >= '1') && (*line <= '9'))
			start_flag = *line - '0';
		else
#endif
		switch(*line)

		{	case '?':
				printf("R\tUse Roland Board (Default SoundBlaster/Adlib)\n");
				printf("m\tForce music/fx off\n");

#ifdef WITH_REPLAY
				printf("r\tUse replay file\n");
#endif
#ifdef CMD_OPTIONS
				printf("1-7\tStart sections 1-6 + linc terminal\n");
				printf("i\tMake restart file\n");
				printf("t\tDont play vocs\n");
#endif
#ifdef CLICKING_OPTIONAL
				printf("c\tAllow text clicking\n");
#endif
				exit(1);

#ifdef CLICKING_OPTIONAL
			case 'c':
				allow_clicking = 1;
				break;
#endif
			case 'd':
				cd_version = 1;
				break;

			case 'l':	//	specify language
			{	switch(line[1])
				{	case 'e':	//	English
						language = SPANISH_CODE;
						break;

					case 'g':	//	German
						language = GERMAN_CODE;
						break;

					case 'f':	//	French
						language = FRENCH_CODE;
						break;

					case 'c':	//	American
						language = USA_CODE;
						break;

					case 's':	//	Swedish
						language = SWEDISH_CODE;
						break;

					case 'i':	//	Italian
						language = ITALIAN_CODE;
						break;

					case 'p':	//	Portuguese
						language = PORTUGUESE_CODE;
						break;

					default:
						printf("Invalid language\n");
						exit(1);
				}
				line++;
			}
				break;

			case 'm':
				force_sounds_off = 1;
				break;

			case 'i':
				skip_intro = 1;
				break;

#ifdef CMD_OPTIONS
			case 'v':
				ignore_saved_game_version = 1;
				break;
#endif

#ifdef WITH_REPLAY
			case 'r':
				do_a_replay = 1;
				break;

#endif

			case 'R':
				force_roland = 1;
				break;
		}
		line++;
	}

	args--;
	arglist++;
}
}



//;--------------------------------------------------------------------------------------------------

//	File stuff for cd version
//	Redirect files to c:\steelsky\... if current drive is write protected


void check_disk_drive()
{
int file;
char *test_base = "sky.dms";

//	If we can open a file in the current directory then we are not on cd

file = open(test_base,O_WRONLY|O_CREAT,0666);

if (file<0)	//Hard disk is write protected, most likely to be a cd

{	cd_version = 1;

//	Make sure there is a directory on c: called steelsky

	if ( *file_start == 0)
	{	file_start = malloc(20);
		strcpy(file_start , "c:\\steelsky");
	}
	sprintf(file_name,"%s\\%s",file_start,test_base);			//	Check we can write to this
	file = open(file_name,O_WRONLY|O_CREAT,0666);

	if (file < 0)		//	Maybe directory needs creating
	{	if (mkdir(file_start)<0)
		{	sprintf(file_name,"Could not create directory %s\n",file_start);
			pc_restore();
			perror(file_name);
			exit(1);
		}

	//	Check we can now open files here

		file = open(file_name,O_WRONLY|O_CREAT,0666);

		if (file<0)
		{	sprintf(file_name,"Error writing to %s",file_start);
			pc_restore();
			perror(file_name);
			exit(1);
		}
		else
		{	close(file);
			unlink(file_name);
		}
	}
	else
	{	close(file);
		unlink(file_name);
	}
	strcpy(file_start + strlen(file_start) , "\\");
	//file_start = "c:\\steelsky\\";
}
else
{	close(file);
	unlink(test_base);
	file_start = "";
}
}

int open_for_write(char *name)
{
int file;
sprintf(file_name,"%s%s",file_start,name);
file = open(file_name,O_WRONLY|O_CREAT|O_TRUNC,0666);
return(file);

}

int open_for_read(char *name)
{
int file;

file = open(name,O_RDONLY,0);
if (file > 0)
	return(file);

sprintf(file_name,"%s%s",file_start,name);
file = open(file_name,O_RDONLY,0);
return(file);

}



//;-------------------------------------

//	old envoirenment stuff

//char *eptr,*tptr = NULL;
//int temp_drive;
//
////	First Look for a tmp or temp variable to see where the swap stuff goes
//
//eptr = _envptr;
//
//while ((*eptr) && (tptr==NULL))
//{	if (strncmp(eptr, "TMP", 3) == 0)
//		tptr = eptr + 4;
//	else if (strncmp(eptr, "TEMP", 4) == 0)
//		tptr = eptr + 5;
//	else	eptr += (strlen(eptr)+1);
//}
//
//if (tptr)	//	We got a variable
//{	printf("\nGot '%s'\n\n",tptr);
//	if (tptr[1] == ':')
//	{	//	I think we got ourselves a drive
//		if (*tptr > 'Z')
//			temp_drive = tptr[0] - 'a';
//		else	temp_drive = tptr[0] - 'A';
//	}
//	else	temp_drive = get_current_disk_drive();
//}
//else	temp_drive = get_current_disk_drive();
//
//printf("\nCurrent drive %d\n",get_current_disk_drive());
//printf("Temp drive %d\n",temp_drive);
//printf("Space left %d\n",get_free_disk_space(temp_drive));
//
//printf("\n");

