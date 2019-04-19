#include "include.hpp"





#ifdef AR_DEBUG

void debug_route_grid(short *route_data)
{
int x,y;

for (y=0;y<GRID_H;y++)

	for (x=0;x<GRID_W;x++)

		draw_box(route_data[y*GRID_W+x]&63,x*BLOCK_SIZE,y*BLOCK_SIZE,BLOCK_SIZE,BLOCK_SIZE);

if (mgetch()=='d')
	debug_flag &= 0xfffffffe;

}


#endif
