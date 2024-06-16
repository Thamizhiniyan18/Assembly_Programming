; Importing the C functions. These will be linked while compiling this program with gcc
extern printf
extern exit

section .data
  msg1 db "Everyone!!!"
  msg2 db "Success!!!"
  exit_code db 0
  format db "Hello %s, Testing printf: %s, Exiting with code: %d"

section .bss

section .text
  global main                  ; Must be declared main for using gcc

main:
  ; Pushing values to stack, since c requires the content to be in stack. 
  ; C printf SYNTAX: printf(FORMAT, VALUES)
  ; Since stack follows LIFO, pushing in reverse order
  ; i.e, first pushing the VALUES and the FORMAT
  push exit_code
  push msg2
  push msg1
  push format
  call printf                   ; Calling the C printf Function
  
  push exit_code                ; Argument for the exit c function
  call exit                     ; Calling the exit function
