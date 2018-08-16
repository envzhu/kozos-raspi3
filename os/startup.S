	.section .text
	.global	_start
_start:
  // disable IRQ/FIQ interrupt
  msr   daifset, #3
  // read cpu id, stop slave cores
  mrs		x0, mpidr_el1
  and 	x0, x0, #3
  // if cpu id > 0, stop
  cbnz  x0, _stop

  ldr		x0, =_bootstack
  mov		sp, x0
	bl		main

_stop:
  msr   daifset, #3
1:
	wfe
	b	1b


	.global	dispatch
dispatch:
	mov		sp, x0
  ldp   x18, x19, [sp], #16
  ldp   x16, x17, [sp], #16
  ldp   x14, x15, [sp], #16
  ldp   x12, x13, [sp], #16
  ldp   x10, x11, [sp], #16
  ldp   x8,  x9,  [sp], #16
  ldp   x6,  x7,  [sp], #16
  ldp   x4,  x5,  [sp], #16
  ldp   x2,  x3,  [sp], #16
  ldp   x0,  x1,  [sp], #16
  eret
