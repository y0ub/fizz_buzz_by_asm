.intel_syntax noprefix
.global main

main:
  mov rcx, 0x1 # destroy by systemocall,
               # need push before call syscall and pop after syscall

# div   : rax % <arg> ->  rax <- ans, rdx <- mod
# syntax: div <arg>

loop:

isfizzbuzz:
  mov rdx, 0
  mov rax, rcx
  mov r8, 15
  div r8
  cmp rdx, 0
  jne isfizz
  mov rdx, 0x9
  lea rsi, fizzbuzz[rip]
  jmp print

isfizz:
  mov rdx, 0
  mov rax, rcx
  mov r8, 3
  div r8
  cmp rdx, 0
  jne isbuzz
  mov rdx, 0x5
  lea rsi, fizz[rip]
  jmp print

isbuzz:
  mov rdx, 0
  mov rax, rcx
  mov r8, 5
  div r8
  cmp rdx, 0
  jne printnewline
  mov rdx, 0x5
  lea rsi, buzz[rip]
  jmp print

printnewline:
  mov rdx, 0x1
  lea rsi, newline[rip]

print:
  mov rax, 0x2000004
  mov rdi, 0
  push rcx
  syscall
  pop rcx
  jmp next

next:
  cmp rcx, 0x100
  jz exit
  inc rcx
  jmp loop

exit:
  mov rax, 0x2000001
  syscall

fizzbuzz:
  .ascii "fizzbuzz\n"

fizz:
  .ascii "fizz\n"

buzz:
  .ascii "buzz\n"

newline:
  .ascii "\n"
