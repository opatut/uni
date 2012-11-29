;====================================
; Ihr Hauptprogramm
;====================================
	
      halt
;=================================================
LDR5:
      ldw    r5, (r15)
      addi   r15, 2
      jmp    r15
;=================================================
; Unterprogramm zur Berechnung des Quadrats
;================================================ 
nh2:
      movi   r7, 0
      movi   r8, 0
nh2loop:
      cmpe   r8, r5
      bt     nh2ende
      addu   r7, r8
      addu   r7, r8
      addi   r8, 1
      br     nh2loop
nh2ende:
      addu   r7, r5
      jmp    r15

     
