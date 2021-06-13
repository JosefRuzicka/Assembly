;PROGRAMA QUE DIBUJA UN RECTANGULO EN MODO GRAFICO
    ; AL = Modo de video. 0Eh: 640x200X16
    ;INT 10H Funcion 0CH
    ;Escribir un punto =  pixel grafico
    ;LLAMADA:
    ;AH = 0CH
    ;AL = Valor del color a usar.
    ;BH = Pagina de v?deo donde escribir el caracter.
    ;CX = Columna donde escribir el pixel (coordenada grafica x)
    ;CX = Fila donde escribir el pixel (coordenada grafica y)
    ;DEVUELVE: NADA.
    ;EFECTO: Da un nuevo color a un pixel grafico.
    ;       Funcion valida solo para modos gr?ficos. 
  
   .MODEL small
    .STACK 200H
    .DATA
    tr      DW 50
    tc      DW 100
    br      DW 100
    bc      DW 200
    colorBLUE   EQU 09H
    colorgreen  EQU 0AH

    .CODE

PROGI:
    mov ax,@data
    mov ds,ax

    ;INT 10H Funcion 00H
    ;Establecer modo de Video
        ;LLAMADA:
        ;    AH = 00H
        ;    AL = Modo de video. 0Eh: 640x200X16

    mov ah,0
    mov al,0EH
    int 10H     ;llamada al BIOS set graphic mode

    mov cx,bc
    sub cx,tc
    mov si,tr
    mov di,tc
    
toploop:
    call    writedot
    inc di
    loop    toploop

    mov cx,br
    sub cx,tr
    mov si,tr
    
  sideloop:
    mov di,tc
    call    writedot
    mov di,bc
    call    writedot
    inc si
    loop    sideloop

    mov cx,bc
    sub cx,tc
    mov si,br
    mov di,tc
        botloop:
            call    writedot
            inc di
        loop    botloop

    .exit   ;TERMINA EJECUCION



 writedot PROC
    push    ax
    push    cx
    push    dx

    mov dx,si
    mov cx,di
    mov al,colorgreen
    mov ah,0CH
    int 10h         ;llamada al BIOS write pixel

    pop dx
    pop cx
    pop ax
    ret
  writedot ENDP

END PROGI
