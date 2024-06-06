section .data
  msg db "The Given Numbers are 4 and 2.", 0xA, 0xD
  len equ $- msg

  add_msg db "Sum of the Given Numbers is: "
  add_msg_len equ $- add_msg

  sub_msg db "Difference of the Given Numbers is: "
  sub_msg_len equ $- sub_msg

  newline db 0xA
  newline_len equ $- newline

section .bss
  sum resb 1
  dif resb 1
  prod resb 1
  division resb 1

section .text
  global _start                         ; Must be declared for using gcc

_start:
  ; Printing the Message
  mov edx, len                          ; Length of the Message
  mov ecx, msg                          ; Message
  mov ebx, 1                            ; File descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernel Interrupt

_sum:
  ; Performing Addition
  mov eax, '4'
  add eax, '2'
  aaa                                   ; ASCII Adjust After Addition
  add eax, '0'                          ; Decimal to ASCII
  mov [sum], eax

_sub:
  ; Performing Subtraction
  mov eax, '4'
  sub eax, '2'
  aas                                   ; ASCII Adjust After Subtraction
  add eax, '0'                          ; Decimal to ASCII
  mov [dif], eax

  ; Printing Result Message: Sum
  mov edx, add_msg_len                  ; Length of the Message
  mov ecx, add_msg                      ; Message
  mov ebx, 1                            ; file descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernel Interrupt

  ; Printing Result: Sum
  mov edx, 1                            ; Size of res
  mov ecx, sum                          ; Result
  mov ebx, 1                            ; file descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernel Interrupt

  call _newline

  ; Printing Result Message: Sub
  mov edx, sub_msg_len                  ; Length of the Message
  mov ecx, sub_msg                      ; Message
  mov ebx, 1                            ; file descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernel Interrupt

  ; Printing Result: Sub
  mov edx, 1                            ; Size of res
  mov ecx, dif                          ; Result
  mov ebx, 1                            ; file descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernel Interrupt
  
  call _newline

  ; Exiting the Program
  mov ebx, 0                ; no errors; return 0
  mov eax, 1                ; sys_exit
  int 0x80                  ; Kernel Interrupt
  
_newline:  
  ; Printing Newline
  mov edx, newline_len                  ; Size of newline
  mov ecx, newline                      ; Newline
  mov ebx, 1                            ; file descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernel Interrupt
  ret
