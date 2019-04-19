#include "include.hpp"

#ifdef WITH_VOC_EDITOR

#define NO_DISPLAY_LINES	10
#define DISPLAY_LINE_LEN	80

char **lines_text;
int	voc_file = 0;
char *	voc_data = NULL;
int	voc_data_size = 0;


void	display_lines(void);
void	expand_voc(void);
void	load_voc_file();
void	play_voc_chunk(int,int);
void	play_voc_data(char *,int,int);
void	redisplay_line(int,char *);
void	update_line(int);
void	bincpy(void *,void *,int);


void voc_editor()
{
int count,leave=0;

debug_printf("Voc editor start...");

//	Play around with voc files

lines_text = malloc(NO_DISPLAY_LINES*sizeof(char *));

for (count=0; count<NO_DISPLAY_LINES; count++)
{	lines_text[count] = malloc(DISPLAY_LINE_LEN);
	lines_text[count][0] = 0;
}

sprintf(lines_text[0],"Voc Editor.");
update_line(0);

while (!leave)

{	display_lines();

	switch(mgetch())

	{	case 'l':	//	Load in a voc file

			load_voc_file();
			break;

		case 'p':
			if (voc_data_size)
				play_voc_chunk(0,100000);
			else
			{	sprintf(lines_text[1],"No voc file to play");
				update_line(1);
			}
			break;

		case 'x':	//	Pad out data

			if (voc_data_size)
				expand_voc();
			else
			{	sprintf(lines_text[1],"No voc file to expand");
				update_line(1);
			}
			break;

		case 27:
			leave = 1;
			break;
	}
}

for (count=0; count<NO_DISPLAY_LINES; count++)
	free(lines_text[count]);
free(lines_text);
if (voc_data_size)
	free(voc_data);

voc_data = (char *)(voc_file = voc_data_size = 0);

debug_printf("Voc editor start...");
}

void update_line(int line_num)
{

redisplay_line(line_num,lines_text[line_num]);

}

void load_voc_file()

{	char name[9];
	int got_name = 0,cursor = 0,count;

	sprintf(lines_text[1],"Enter voc name...");
	update_line(1);
	display_lines();

	while (!got_name)

	{	char ch = mgetch();

		if ( (ch > ' ') && (ch < 126) )

		{	name[cursor++] = ch;
			name[cursor] = 0;
			if (cursor >= 8)
				got_name = 1;
			else
			{	sprintf(lines_text[1],"Load %s.voc",name);
				update_line(1);
				display_lines();
			}
		}
		else switch(ch)
		{	case 13:
				got_name = 1;
				break;

			case 27:
				got_name = (-1);
				break;
		}
	}

	if (got_name == 1)

	{	char filename[13];

		sprintf(filename,"%s.voc",name);
		voc_file = open(filename,O_RDONLY,0);
		if (voc_file < 0)
		{	sprintf(lines_text[1],"%s.voc not found",name);
			update_line(1);
			voc_file=0;
		}
		else
		{	struct stat status;
			char *ldata,*lpointer;

			if (voc_data_size)
			{	free(voc_data);
				voc_data_size = 0;
			}

			fstat(voc_file,&status);
			ldata = malloc(status.st_size);
			read(voc_file,ldata,status.st_size);
			close(voc_file);

		//	Combine all the data together

			if (strncmp(ldata,"Creative Voice File",19)!=0)
			{	debug_printf("Not a Voc file");
				pc_restore();
				exit(1);
			}

			debug_printf("Data offset %x",*((short *)(ldata+20)));
			debug_printf("Version %x",*((short *)(ldata+22)));
			debug_printf("code %x",*((short *)(ldata+24)));

			lpointer = ldata + *((short *)(ldata+20));

			while (*lpointer)	//	while not block type 0

			{	debug_printf("Block type %d",*lpointer);

				switch(*lpointer)

				{	case 1:	//	Sound data block

					{	int bsize = *((int *)(lpointer+1));
						bsize &= 0xffffff;
						debug_printf("Old block size %d",bsize);

						if (voc_data_size)
							voc_data = realloc(voc_data,voc_data_size + bsize);
						else	voc_data = malloc(voc_data_size + bsize);

						bincpy(voc_data+voc_data_size,lpointer+6,bsize-2);

						voc_data_size += (bsize-2);
						lpointer += (bsize+4);
					}
						break;

					case 9:	//	New sound data block

					{	int bsize = *((int *)(lpointer+1));
						bsize &= 0xffffff;
						debug_printf("New block size %d",bsize);

						if (voc_data_size)
							voc_data = realloc(voc_data,voc_data_size + bsize);
						else	voc_data = malloc(voc_data_size + bsize);

						bincpy(voc_data+voc_data_size,lpointer+16,bsize-12);

						voc_data_size += (bsize-12);
						lpointer += (bsize+4);
					}
						break;

					default:
						debug_printf("Invalid type %d",*lpointer);
						*lpointer = 0;
						break;
				}
			}

			sprintf(lines_text[1],"Voc file : %s Size %d",name,voc_data_size);
			update_line(1);

		}
	}
}


void play_voc_chunk(int start,int len)
{

if (start >= voc_data_size)
	return;

if ( (start+len) > voc_data_size)
	len = voc_data_size - start;

if (len >= 65000)
	len = 65000;

play_voc_data(voc_data + start, len, 0);
}

void expand_voc()
{
int count;

voc_data = realloc(voc_data,voc_data_size*2);

for (count = voc_data_size; count>=0; count--)
{	voc_data[count*2] = voc_data[count];
	voc_data[count*2+1] = voc_data[count];
}

voc_data_size *= 2;

}

#endif


