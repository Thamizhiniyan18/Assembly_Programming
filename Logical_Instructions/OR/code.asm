section .data

section .bss
  res resb 1

section .text
  global _start                         ; Must be declared for using gcc

_start:
  mov eax, 5
  mov ebx, 3
  or eax, ebx
  add eax, '0'                          ; Decimal to ASCII
  mov [res], eax

  ; Printing the result
  mov edx, 1                            ; Size of res
  mov ecx, res                          ; result
  mov ebx, 1                            ; file descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernel Interrupt

  ; Exiting the program
  mov eax, 1                            ; sys_exit
  int 0x80                              ; kernel Interrupt

