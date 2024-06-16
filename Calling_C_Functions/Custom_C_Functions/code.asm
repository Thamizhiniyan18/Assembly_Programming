extern add
extern printf
extern exit

section .data
  format db "Sum of 2 and 1 is: %d"

section .bss

section .text
  global main                   ; Must be declared for using gcc

main:
  ; Performing the Addition
  push 1                        ; Pushing the second number to stack
  push 2                        ; Pushing the first number to stack
  call add                      ; calling the custom c function add; returns the sum to eax

  ; Printing the Result
  push eax                      ; Pushing the result to the stack
  push format                   ; Pushing the format to the stack
  call printf                   ; Calling the standard c function printf

  ; Exiting the program
  push 0                        ; Exit Code
  call exit                     ; Calling the standard c function exit
