section .data

section .bss
  res resb 1

section .text
  global _start                         ; Must be decalred for using gcc

_start:
  mov eax, 5
  xor eax, eax
  add eax, '0'                          ; Decimal to ASCII
  mov [res], eax                        ; Storing the result in res

  ; Printing the result
  mov edx, 1                            ; length of res
  mov ecx, res                          ; Result
  mov ebx, 1                            ; file descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernal Interrupt

  ; Exiting the Program
  mov eax, 1                            ; sys_exit
  int 0x80                              ; Kernal Interrupt
