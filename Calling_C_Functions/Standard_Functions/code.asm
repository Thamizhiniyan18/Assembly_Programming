; Importing the C functions. These will be linked while compiling this program with gcc
extern printf
extern exit

section .data
  msg1 db "Everyone!!!"
  msg2 db "Success!!!"
  exit_code db 0
  format db "Hello %s\n Testing printf: %s\nexiting with code %d"

section .bss

section .text
  global _main                  ; Must be declared main for using gcc

_start:
  ; Pushing values to stack, since c requires the content to be in stack. 
  ; Since stack follows LIFO, pushing in reverse order
  push exit_code
  push msg2
  push msg1
  call printf                   ; Calling the C printf Function
  
  push exit_code                ; Argument for the exit c function
  call exit                     ; Calling the exit function
