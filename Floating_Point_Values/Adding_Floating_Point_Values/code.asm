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
  num2 dd 3.1

  msg db "Successfully Performed the addition. Check the result using gdb: p $xmm0.v4_float[0]"
  len equ $- msg

section .bss

section .text
  global _start

_start:
  ; Performing Floating Point Addition
  movss xmm0, [num1]        ; Moving Scaler Single Precision Value to xmm0 special register
  movss xmm1, [num2]        ; Moving Scaler Single Precision Value to xmm1 special register
  addss xmm0, xmm1          ; Adding Scaler Single Precision Values

  ; Printing the Result Message and result
  print len, msg

  ; Exiting the Program
  exit 0
