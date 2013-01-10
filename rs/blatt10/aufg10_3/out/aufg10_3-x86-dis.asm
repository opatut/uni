
out/aufg10_3-x86.o:     file format elf32-i386


Disassembly of section .text.startup:

00000000 <main>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
   9:	c7 44 24 08 1d e3 61 	movl   $0x61e31d,0x8(%esp)
  10:	00 
  11:	c7 44 24 04 1d e3 61 	movl   $0x61e31d,0x4(%esp)
  18:	00 
  19:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  20:	e8 fc ff ff ff       	call   21 <main+0x21>
  25:	31 c0                	xor    %eax,%eax
  27:	c9                   	leave  
  28:	c3                   	ret    
