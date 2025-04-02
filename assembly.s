.section .data
    input_line_prompt: .asciz "Введите строку\n"
    input_subline_prompt: .asciz "Введите подстроку\n"
    yes_msg: .asciz "Yes\n"
    no_msg: .asciz "No\n"
    newline: .asciz "\n"

.section .bss
    .lcomm line, 256
    .lcomm subline, 256
    .lcomm double_line, 512

.section .text
    .globl _start

_start:
    # Вывод приглашения для ввода строки
    mov $input_line_prompt, %rdi
    call puts

    # Чтение первой строки
    mov $line, %rdi
    mov $255, %rsi         # Читаем на 1 байт меньше размера буфера
    call read_line

    # Вывод приглашения для ввода подстроки
    mov $input_subline_prompt, %rdi
    call puts

    # Чтение подстроки
    mov $subline, %rdi
    mov $255, %rsi         # Читаем на 1 байт меньше размера буфера
    call read_line

    # Вызов функции first_task
    mov $line, %rdi
    mov $subline, %rsi
    call first_task

    # Проверка результата
    test %rax, %rax
    jz print_no

    # Вывод "Yes"
    mov $yes_msg, %rdi
    call puts
    jmp exit_program

print_no:
    # Вывод "No"
    mov $no_msg, %rdi
    call puts

exit_program:
    # Завершение программы
    mov $60, %rax
    xor %rdi, %rdi
    syscall

first_task:
    push %rbp
    mov %rsp, %rbp
    push %rbx
    push %r12
    push %r13

    mov %rdi, %r12         # Сохраняем адрес строки
    mov %rsi, %r13         # Сохраняем адрес подстроки

    # Проверяем длины строк
    mov %r12, %rdi
    call strlen
    mov %rax, %rbx         # RBX = длина строки

    mov %r13, %rdi
    call strlen
    cmp %rbx, %rax
    jne first_task_false   # Если длины не равны - false

    # Проверка на пустые строки
    cmp $0, %rbx
    je first_task_true     # Две пустые строки считаем совпадающими

    # Создаем line + line
    mov $double_line, %rdi
    mov %r12, %rsi
    call strcpy

    mov $double_line, %rdi
    mov %r12, %rsi
    call strcat

    # Ищем подстроку в удвоенной строке
    mov $double_line, %rdi
    mov %r13, %rsi
    call strstr
    test %rax, %rax
    jz first_task_false    # Если не найдено - false

    # Проверяем, что подстрока начинается в пределах первых n символов
    mov %rax, %rcx         # Адрес найденной подстроки
    sub $double_line, %rcx # Смещение относительно начала
    cmp %rbx, %rcx         # Смещение должно быть < длины строки
    jge first_task_false   # Иначе это не циклический сдвиг

    # Дополнительная проверка: следующие n символов должны совпадать с подстрокой
    mov %rbx, %rdx         # Длина для сравнения
    mov %rax, %rdi         # Начало найденной подстроки
    mov %r13, %rsi         # Оригинальная подстрока
    call strncmp
    test %rax, %rax
    jnz first_task_false   # Если не совпадают - false

first_task_true:
    mov $1, %rax           # Возвращаем true
    jmp first_task_end

first_task_false:
    xor %rax, %rax         # Возвращаем false

first_task_end:
    pop %r13
    pop %r12
    pop %rbx
    leave
    ret

strlen:
    xor %rax, %rax
strlen_loop:
    cmpb $0, (%rdi,%rax)
    je strlen_end
    inc %rax
    jmp strlen_loop
strlen_end:
    ret

strcpy:
    mov %rdi, %rax
strcpy_loop:
    movb (%rsi), %dl
    movb %dl, (%rdi)
    test %dl, %dl
    jz strcpy_end
    inc %rsi
    inc %rdi
    jmp strcpy_loop
strcpy_end:
    ret

strcat:
    push %rdi
strcat_find_end:
    cmpb $0, (%rdi)
    jz strcat_copy
    inc %rdi
    jmp strcat_find_end
strcat_copy:
    call strcpy
    pop %rax
    ret

strstr:
    mov %rdi, %rax
strstr_outer:
    mov %rsi, %rdx
    mov %rax, %rcx
strstr_inner:
    movb (%rdx), %dl
    test %dl, %dl
    jz strstr_found
    cmpb %dl, (%rcx)
    jne strstr_next
    inc %rdx
    inc %rcx
    jmp strstr_inner
strstr_next:
    inc %rax
    cmpb $0, (%rax)
    jnz strstr_outer
    xor %rax, %rax
strstr_found:
    ret

strncmp:
    xor %rax, %rax
strncmp_loop:
    test %rdx, %rdx
    jz strncmp_end
    movb (%rdi), %al
    movb (%rsi), %cl
    cmp %al, %cl
    jne strncmp_diff
    inc %rdi
    inc %rsi
    dec %rdx
    jmp strncmp_loop
strncmp_diff:
    sub %cl, %al
    movsx %al, %rax
strncmp_end:
    ret

puts:
    push %rdi
    call strlen
    mov %rax, %rdx
    pop %rsi
    mov $1, %rax
    mov $1, %rdi
    syscall
    ret

read_line:
    push %rbp
    mov %rsp, %rbp
    push %rbx
    push %r12
    
    mov %rdi, %r12         # Сохраняем адрес буфера
    mov %rsi, %rbx         # Сохраняем размер буфера

    # Системный вызов read
    mov $0, %rax           # sys_read
    mov $0, %rdi           # stdin
    mov %r12, %rsi         # буфер
    mov %rbx, %rdx         # размер
    syscall

    # Проверяем результат
    cmp $0, %rax
    jle read_line_error    # Если ошибка или EOF

    # Заменяем \n на \0
    dec %rax               # Возвращаемся на позицию перед \n
    movb $0, (%r12, %rax)  # Заменяем \n на \0

read_line_exit:
    pop %r12
    pop %rbx
    leave
    ret

read_line_error:
    movb $0, (%r12)        # Гарантируем нуль-терминатор
    jmp read_line_exit
