section .data                   ;nesta sessao se declaram as constantes
    pergunta db "Qual e seu nome? "
    cumprimento db "Bem vindo, "

section .bss                    ;nessa secao se definem variaveis
nome:  resb    20               ;reserva na variavel de label 'input' 20 bytes

section .text                   ;inicio da seccao de texto
    global _start               ;onde deve comecar a execucao

_start:                         ;label start - a execucao inicia aqui
    ;; perguntar nome do usuario
    mov eax, 4
    mov ebx, 1
    mov ecx, pergunta
    mov edx, 17
    int 0x80                     ;queremos chamar a sys_write, portanto eax=4, ebx=int, ecx=string e edx=tamanho da string

    ;; ler input do usuario
    mov eax, 3
    mov ebx, 1
    mov ecx, nome
    mov edx, 20
    int 0x80                    ;sys_read, eax=3, ebx=int, ecx=string e edx=tamanho da string


    ;; imprimir o cumprimento
    mov eax, 4
    mov ebx, 1
    mov ecx, cumprimento
    mov edx, 11
    int 0x80                    ;sys_write

    ;; imprimir o nome do usuario
    mov eax, 4
    mov ebx, 1
    mov ecx, nome
    mov edx, 11
    int 0x80                    ;sys_write

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
