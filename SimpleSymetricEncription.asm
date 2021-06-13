TITLE Programa de cifrado (Cifrado.asm)
; Este programa demuestra el cifrado sim?trico
; simple mediante el uso de la instrucci?n XOR.
; Ejemplo del cap?tulo 6.
; ?ltima actualizaci?n: 06/01/2006

CLAVE = 239 ; cualquier valor entre 1-255
MAXBUF = 128 ; tama?o m?ximo del b?fer
.data
sIndicador BYTE "Escriba el texto simple: ",0
sCifrado BYTE "Texto cifrado: ",0
sDescifrado BYTE "Descifrado: ",0
bufer BYTE MAXBUF+1 DUP(0)
tamBufer DWORD ?
.code
main PROC
call IntroducirLaCadena ; introduce el texto simple
call TraducirBufer ; cifra el b?fer
mov edx,OFFSET sCifrado ; muestra el mensaje cifrado
call MostrarMensaje
call TraducirBufer ; descifra el b?fer
mov edx,OFFSET sDescifrado ; muestra el mensaje descifrado
call MostrarMensaje
exit
main ENDP
6.3 Saltos condicionales 165

166 Cap?tulo 6 ? Procesamiento condicional
;-----------------------------------------------------
IntroducirLaCadena PROC
;
; Pide al usuario una cadena de texto simple. Guarda la cadena
; y su longitud.
; Recibe: nada
; Devuelve: nada
;-----------------------------------------------------
pushad
mov edx,OFFSET sIndicador ; muestra un indicador
call WriteString
mov ecx,MAXBUF ; cuenta m?xima de caracteres
mov edx,OFFSET bufer ; apunta al b?fer
call ReadString ; recibe la cadena de entrada
mov tamBufer,eax ; guarda la longitud
call Crlf
popad
ret
IntroducirLaCadena ENDP
;-----------------------------------------------------
MostrarMensaje PROC
;
; Muestra el mensaje cifrado o descifrado.
; Recibe: EDX apunta al mensaje
; Devuelve: nada
;-----------------------------------------------------
pushad
call WriteString
mov edx,OFFSET bufer ; muestra el b?fer
call WriteString
call Crlf
call Crlf
popad
ret
MostrarMensaje ENDP
;-----------------------------------------------------
TraducirBufer PROC
;
; Traduce la cadena mediante un OR exclusivo con cada
; byte y el byte de la clave de cifrado.
; Recibe: nada
; Devuelve: nada
;-----------------------------------------------------
pushad
mov ecx,tamBufer ; contador del ciclo
mov esi,0 ; ?ndice 0 en el b?fer
L1:
xor bufer[esi],CLAVE ; traduce un byte
inc esi ; apunta al siguiente byte
loop L1
popad
ret
TraducirBufer ENDP
END main