section .data
  name db 'zuha ali', 0xa           ; declaring name
  name_length equ $ - name          ; length of name

section .bss

section .text
  global _start

_start:
  ; Printing zuha ali
  mov edx, name_length              ; Length of the name
  mov ecx, name                     ; name to be displayed
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; system call (sys_write)
  int 0x80                          ; calling kernal

  ; replacing zuha with nuha
  mov [name], dword 'nuha'

  ; Printing nuha ali
  mov edx, name_length              ; length of the name
  mov ecx, name                     ; name to be displayed
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; system call (sys_write)
  int 0x80                          ; calling kernel

  ; Exiting the Program
  mov eax, 1                        ; system call (sys_exit)
  int 0x80                          ; calling kernel
