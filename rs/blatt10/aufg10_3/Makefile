FILENAME=aufg10_3
OUT=out/

default: all

all: asm obj bin dis

asm: asm32 asm64
obj: obj32 obj64
bin: bin32 bin64
dis: dis32 dis64

asm32:
	gcc -O2 -m32 -S -o ${OUT}${FILENAME}-x86.asm ${FILENAME}.c

asm64:
	gcc -O2 -S -o ${OUT}${FILENAME}-x64.asm ${FILENAME}.c

obj32:
	gcc -O2 -m32 -c -o ${OUT}${FILENAME}-x86.o ${FILENAME}.c

obj64:
	gcc -O2 -c -o ${OUT}${FILENAME}-x64.o ${FILENAME}.c

bin32:
	gcc -O2 -m32 -o ${OUT}${FILENAME}-x86 ${FILENAME}.c

bin64:
	gcc -O2 -o ${OUT}${FILENAME}-x64 ${FILENAME}.c

dis32:
	objdump -d ${OUT}${FILENAME}-x86.o > ${OUT}${FILENAME}-x86-dis.asm

dis64:
	objdump -d ${OUT}${FILENAME}-x64.o > ${OUT}${FILENAME}-x64-dis.asm
