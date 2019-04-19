CFLAGS = -c -mx -g -C -s
CFLAGS = -c -mx -C
AFLAGS = /c /Zi /VM /nologo
AFLAGS = /c /VM /nologo



sky.exe: replay.obj main.obj rn_deco.obj initiali.obj debug.obj timer.obj keyboard.obj mouse.obj error.obj disk.obj lists.obj \
	 logic.obj screen.obj sprites.obj 0compact.obj 1compact.obj 2compact.obj 3compact.obj ar_dbgc.obj voc_c.obj \
	 4compact.obj 5compact.obj 6compact.obj memory.obj intro.obj control.obj layers.obj function.obj debugc.obj \
	 autoroot.obj grid.obj text.obj decodee.obj mousesys.obj music.obj timer.obj voc_asm.obj finish.obj wanim.obj \
	 cd_intro.obj scr_int.obj
	 ml $(AFLAGS) start.asm
	 blinkx @makefile.lnk
	 del *.err



main.obj:       main.cpp
		ztc $(CFLAGS) main.cpp

debugc.obj:     debugc.cpp
		ztc $(CFLAGS) debugc.cpp

ar_dbgc.obj:    ar_dbgc.cpp
		ztc $(CFLAGS) ar_dbgc.cpp

voc_c.obj:      voc_c.cpp
		ztc $(CFLAGS) voc_c.cpp

initiali.obj:   initiali.asm
		ml $(AFLAGS) initiali.asm

debug.obj:      debug.asm
		ml $(AFLAGS) debug.asm

timer.obj:      timer.asm
		ml $(AFLAGS) timer.asm

keyboard.obj:   keyboard.asm
		ml $(AFLAGS) keyboard.asm

mouse.obj:      mouse.asm
		ml $(AFLAGS) mouse.asm

error.obj:      error.asm
		ml $(AFLAGS) error.asm

disk.obj:       disk.asm
		ml $(AFLAGS) disk.asm

scr_int.obj:    scr_int.asm script.asm
		ml $(AFLAGS) scr_int.asm

lists.obj:      lists.asm lists.inc
		ml $(AFLAGS) lists.asm

logic.obj:      logic.asm
		ml $(AFLAGS) logic.asm

screen.obj:     screen.asm
		ml $(AFLAGS) screen.asm

sprites.obj:    sprites.asm
		ml $(AFLAGS) sprites.asm

0compact.obj:   0compact.asm z_compac.inc objects.inc 101comp.inc
		ml /c /VM 0compact.asm

1compact.obj:   1compact.asm 0compact.inc 1compact.inc 2compact.inc 3compact.inc 4compact.inc
		ml /c /VM 1compact.asm

2compact.obj:   2compact.asm 5compact.inc 9compact.inc 12comp.inc 13comp.inc 14comp.inc 15comp.inc 16comp.inc 17comp.inc 18comp.inc
		ml /c /VM 2compact.asm

3compact.obj:   3compact.asm 10comp.inc 11comp.inc 19comp.inc 20comp.inc 21comp.inc 22comp.inc 23comp.inc 24comp.inc 25comp.inc 26comp.inc 27comp.inc 28comp.inc 29comp.inc
		ml /c /VM 3compact.asm

4compact.obj:   4compact.asm 30comp.inc 31comp.inc 32comp.inc 33comp.inc 34comp.inc 36comp.inc 37comp.inc 38comp.inc 39comp.inc 40comp.inc 41comp.inc 42comp.inc
		ml /c /VM 4compact.asm

5compact.obj:   5compact.asm 66comp.inc 67comp.inc 68comp.inc 69comp.inc 70comp.inc 71comp.inc 72comp.inc 73comp.inc 74comp.inc 75comp.inc 76comp.inc 77comp.inc 78comp.inc 79comp.inc 80comp.inc 81comp.inc 82comp.inc
		ml /c /VM 5compact.asm

6compact.obj:   6compact.asm 90comp.inc 91comp.inc 92comp.inc 93comp.inc 94comp.inc 95comp.inc 96comp.inc lincmenu.inc linc_gen.inc
		ml /c /VM 6compact.asm

layers.obj:     layers.asm
		ml $(AFLAGS) layers.asm

memory.obj:     memory.asm
		ml $(AFLAGS) memory.asm

function.obj:   function.asm
		ml $(AFLAGS) function.asm

autoroot.obj:   autoroot.asm
		ml $(AFLAGS) autoroot.asm

grid.obj:       grid.asm
		ml $(AFLAGS) grid.asm

text.obj:       text.asm
		ml $(AFLAGS) text.asm

decodee.obj:    decodee.asm decoder.asm
		ml $(AFLAGS) decodee.asm

mousesys.obj:   mousesys.asm
		ml $(AFLAGS) mousesys.asm

intro.obj:      intro.asm
		ml $(AFLAGS) intro.asm

music.obj:      music.asm
		ml $(AFLAGS) music.asm

finish.obj:     finish.asm
		ml $(AFLAGS) finish.asm

control.obj:    control.asm
		ml $(AFLAGS) control.asm

deco.obj:       deco.asm
		ml $(AFLAGS) deco.asm

voc_asm.obj:    voc_asm.asm
		ml $(AFLAGS) voc_asm.asm

wanim.obj:      wanim.asm
		ml $(AFLAGS) wanim.asm

replay.obj:     replay.asm
		ml $(AFLAGS) replay.asm

cd_intro.obj:   cd_intro.asm
		ml $(AFLAGS) cd_intro.asm

