section .data
  char db '0'

section .bss

section .text
  global _start

_start:
  mov ecx, 256                      ; Counter for loop

_loop:
  push ecx                          ; pushing ecx to the stack
  
  ; Printing the Character
  mov edx, 1                        ; Length of the Character
  mov ecx, char                     ; Character
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  pop ecx                           ; poping the ecx from stack

  inc byte [char]
  loop _loop
  
  ; Exiting the Program
  mov ebx, 0                        ; No Errors; Return 0
  mov eax, 1                        ; sys_exit
  int 0x80                          ; Kernel Interrupt
