# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strcpy.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jmaydew <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 13:55:39 by jmaydew           #+#    #+#              #
#    Updated: 2020/12/08 13:55:41 by jmaydew          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	C Function prototype: char *ft_strcpy(char *dest, const char *src)  ;
;	Expected input:	rdi = dest, rsi = src                               ;
;	Expected output: rax                                                ;
;	Clobbers:	rax, rcx                                                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

            global  ft_strcpy
            section .text

ft_strcpy:  xor     rax, rax                ; set rax to 0
            xor     rcx, rcx                ; set rcx to 0

copy:       cmp     byte [rsi + rcx], ah    ; compare src + rcx to 0
            jz      end                     ; if 0, end of sring reached
            mov     al, byte [rsi + rcx]    ; else, copy byte in al
            mov     byte [rdi + rcx], al    ; then copy it to dest + rcx
            inc     rcx                     ; rcx += 1
            jmp     copy                    ; loop

end:        mov     byte [rdi + rcx], ah    ; add a 0 at the end of dest
            mov     rax, rdi                ; copy address of dest into rax
            ret                             ; return
