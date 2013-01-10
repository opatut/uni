
out/aufg10_3-x64.o:     file format elf64-x86-64


Disassembly of section .text.startup:

0000000000000000 <main>:
   0:	48 83 ec 08          	sub    $0x8,%rsp
   4:	ba 1d e3 61 00       	mov    $0x61e31d,%edx
   9:	be 1d e3 61 00       	mov    $0x61e31d,%esi
   e:	bf 00 00 00 00       	mov    $0x0,%edi
  13:	31 c0                	xor    %eax,%eax
  15:	e8 00 00 00 00       	callq  1a <main+0x1a>
  1a:	31 c0                	xor    %eax,%eax
  1c:	48 83 c4 08          	add    $0x8,%rsp
  20:	c3                   	retq   
