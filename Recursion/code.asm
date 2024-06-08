section .data
  msg db "Factorial of 3 is: "
  len equ $- msg

section .bss
  factorial resb 1

section .text
  global _start

_start:
  mov ebx, 3                    ; For Calculating the 3!
  call _procedure_factorial
  add ax, '0'
  mov [factorial], ax

  ; Printing the Message
  mov edx, len                  ; Length of the Message
  mov ecx, msg                  ; Message
  mov ebx, 1                    ; File Descriptor (stdout)
  mov eax, 4                    ; sys_write
  int 0x80                      ; Kernel Interrupt

  ; Printing the Factorial
  mov edx, 1                    ; Length of the Factorial
  mov ecx, factorial            ; Factorial
  mov ebx, 1                    ; File Descriptor (stdout)
  mov eax, 4                    ; sys_write
  int 0x80                      ; Kernel Interrupt

  ; Exiting the Program
  mov ebx, 0                    ; No Errors; Return 0
  mov eax, 1                    ; sys_exit
  int 0x80                      ; Kernel Interrupt

_procedure_factorial:
  cmp bl, 1
  jg _procedure_calculation     ; if bl > 1, jump to _procedure_calculation
  mov ax, 1
  ret

_procedure_calculation:
  dec bl
  call _procedure_factorial
  inc bl
  mul bl                        ; ax = al * bl
  ret
