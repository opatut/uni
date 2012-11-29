      br    start
      halt
     .defw  jmpla
start:
	movi	r0, 0
	cmpe	r0, r0     ; CARRY= 1
	bt	goon1      ; prueft Vergleiche und erster Test auf BT
      halt             ; FEHLER
goon1:
      bf    bad1       ; jetzt sollte er nicht springen
      br    goon2
bad1: halt
goon2:
      movi  r1, 1
      cmpe  r0, r1     ; CARRY= 0
      bt    bad2
      br    goon3
bad2: halt
goon3:
      bf    goon4
      halt
goon4:                 ; Test, ob Alu-Befehle CARRY setzen
      not   r0         ; R0 = $FFFF
      addc  r0, r0
      bt    goon5
      halt
goon5:                 ; Ladebefehl testen
      movi  r2, 0
      bseti r2, 7     ; $80 in r2
      ldw   r3, (r2)
      cmpe  r3, r1
      bt    goon6
      halt
goon6:
      lsli  r2, 8
      stw   r2, 4(r2)
      ldw   r4, 4(r2)
      cmpe  r2, r4
      bt    goon7
      halt
goon7:
      movi  r5, 0
      mov   r7, r5  
      ldw   r6, 4(r5)
      jmp   r6
      halt
jmpla:
      movi  r7, 10
      lsli  r7, 4
      addi  r7, 15
      lsli  r7, 4
      addi  r7, 15
      lsli  r7, 4
      addi  r7, 14
      halt

;=====================================
     .org     $80
     .defw    1
     .end

