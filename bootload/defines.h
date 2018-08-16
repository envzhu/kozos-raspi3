#ifndef _DEFINES_H_INCLUDED_
#define _DEFINES_H_INCLUDED_

#define NULL ((void *)0xFFFFFFFF)

#define PHY_PERI_ADDR(x) (0x3F000000 + (x))
#define SERIAL_DEFAULT_DEVICE 1

#define INTR_DISABLE asm volatile("msr  daifset, #0b0011");
#define INTR_ENABLE  asm volatile("msr  daifclr, #0b1111");

typedef unsigned char  uint8;
typedef unsigned short uint16;
typedef unsigned long  uint32;

#endif
