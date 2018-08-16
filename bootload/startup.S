	.section .text
	.global	_start
_start:
  // disable IRQ/FIQ interrupt
  msr   daifset, #3
  // read cpu id, stop slave cores
  mrs		x0, mpidr_el1
  and 	x0, x1, #3
  // if cpu id > 0, stop
  cbnz  x0, 1f

  ldr		x0, =_bootstack
  mov		sp, x0
	bl		main

1:
	b	1b
