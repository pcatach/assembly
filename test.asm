section .data       ;nessa secao se definem constantes
    msg db "Hello World!", 0ah      ;string hello world + new line (13 bytes)
    msgone db "one", 0ah
    msgtwo db "two", 0ah

section .text           ;inicio da seccao de texto
    global _start       ;onde deve comecar a execucao

_start:                         ;label start - a execucao inicia aqui
    ;; write
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 13
    int 0x80                     ;queremos chamar a sys_write, portanto eax=4 ebx precisa de uma int, ecx precisa da string e edx do tamanho da string
    jmp one

one:
    mov eax, 4
    mov ebx, 1
    mov ecx, msgone
    mov edx, 4
    int 0x80                     ;queremos chamar a sys_write, portanto eax=4 ebx precisa de uma int, ecx precisa da string e edx do tamanho da string
    ret
	
two:
    mov eax, 4
    mov ebx, 1
    mov ecx, msgtwo
    mov edx, 4
    int 0x80                     ;queremos chamar a sys_write, portanto eax=4 ebx precisa de uma int, ecx precisa da string e edx do tamanho da string

    ;; exit
    mov eax, 1
    mov ebx, 0
    int 0x80                     ;queremos chamar sys_exit. precisamos de eax=1, uma int em ebx

	;; registradores
	;; EAX		Acumulador	usado em operacoes aritmeticas, acesso a portas
	;; EBX		Base		usado como ponteiro, indice e auxiliar do eax
	;; ECX		Contador	usado como contador em loops
	;; EDX		Dados		mesma coisa que eax, recebe restos de divisao e produtos

	;; eax recebe os valores que representam chamadas:
	;; eax = 1 -> chamada de saida - ebx = valor de saida
	;; eax = 3 -> chamada de input (read) - ebx = valor de saida, ecx = char, edx = lenchar
	;; eax = 4 -> chamada de output (write) -ebx = valor de saida, ecx = const char, edx = lenchar

    ;; compilar: nasm -f elf hello.asm
    ;; link: ld -m elf_i386 -o hello hello.o
