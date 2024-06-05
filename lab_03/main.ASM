EXTRN output_X: near                    ; внешняя ссылка на процедуру output_X

STK SEGMENT PARA STACK 'STACK'          ; сегмент стека
    db 100 dup(0)
STK ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'         ; сегмент данных
    X db 0
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'         ; сегмент кода
    assume CS:CSEG, DS:DSEG, SS:STK
main:
    mov ax, DSEG                        ; загрузка адреса начала сегмента данных в AX
    mov ds, ax                          ; установка регистра сегмента данных DS

    mov ah, 01h                         ; подготовка перед прерыванием. Номер функции для чтения с эхом.
    int 21h                             ; прерывание (читаем символ)
    sub al, '0'                         ; преобразование символа в числовое значение
    mov X, al                           ; сохранение преобразованного значения в переменную X

    call output_X                       ; вызов процедуры для вывода символа

    mov ax, 4c00h                       ; завершение программы
    int 21h
CSEG ENDS

PUBLIC X

END main
