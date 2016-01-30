    section .data

    SYS_EXIT  equ  1
    SYS_WRITE equ  4
    STDOUT    equ  1
    TRAP      equ  0x80
    NUL       equ  0

hello:   db "Hello World",0xA,NUL ; 0xA is linefeed, terminate with NUL

    section .text
    global _start

_start:
    nop                      ; for good old gdb
    mov ecx, hello        ; ecx is the char* to be passed to sys_write

read:
    cmp byte[ecx], NUL       ; NUL indicates the end of the string
    je exit               ; if reached the NUL terminator, exit

    ;;  setup the registers for a sys_write call
    mov eax, SYS_WRITE       ; syscall number for sys_write
    mov ebx, STDOUT       ; print to stdout
    mov edx, 1         ; write 1 char at a time
    ;;  execute the syscall

    inc ecx                  ; increment the pointer to the next char
    jmp read              ; loop back to read

exit:
    mov eax, SYS_EXIT           ; load the syscall number for sys_exit
    mov ebx, 0                  ; return a code of 0
    int TRAP                    ; execute the syscall
       int TRAP
