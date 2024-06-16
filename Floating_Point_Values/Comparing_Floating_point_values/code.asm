%macro print 2
  mov edx, %1               ; Size of the content
  mov ecx, %2               ; The content
  mov ebx, 1                ; File descriptor (stdout)
  mov eax, 4                ; sys_exit
  int 0x80                  ; Kernel Interrupt
%endmacro

%macro exit 1
  mov ebx, %1               ; Exit Code
  mov eax, 1                ; sys_exit
  int 0x80                  ; Kernel Interrupt
%endmacro

section .data
  num1 dd 2.86
  num2 dd 2.1

  less db "Lesser"
  len_less equ $- less

  great db "Greater"
  len_great equ $- great

section .bss

section .text
  global _start

_start:
  ; Performing Floating Point Addition
  movss xmm0, [num1]        ; Moving Scaler Single Precision Value to xmm0 special register
  movss xmm1, [num2]        ; Moving Scaler Single Precision Value to xmm1 special register
  ucomiss xmm0, xmm1        ; Comparing Scaler Single Precision Values
  ja _if_greater                ; Jump if above (greater) to the _if_greater subroutine

  ; Else exiting the Program
  print len_less, less
  exit 0

_if_greater:
  print len_great, great
  exit 0
