/* aufg10_3.c
 * Einfaches Programm zum Test des gcc-Compilers und der zugehörigen Tools.
 * Bitte setzen Sie in das Programm ihre Matrikelnummer ein und probieren
 * Sie alle der folgenden Operationen aus:
 *
 * Funktion         Befehl                                erzeugt
 * ----------------+-------------------------------------+----------------
 * C -> Assembler:  gcc -O2 -S aufg10_3.c                -> aufg10_3.s
 * C -> Objektcode: gcc -O2 -c aufg10_3.c                -> aufg10_3.o
 * C -> Programm:   gcc -O2 -o aufg10_3.exe aufg10_3.c   -> aufg10_3.exe
 * Disassembler:    objdump -d aufg10_3.o
 * Ausführen:       aufg10_3.exe
 *
 * 32bit Code auf 64bit System: gcc -m32 ...
 */

#include <stdio.h>

int main( int argc, char** argv )
{ 
    int matrikelNr = 6415133;
    printf( "Meine Matrikelnummer ist %d (0x%x)\n", matrikelNr, matrikelNr );
    return 0;
}
