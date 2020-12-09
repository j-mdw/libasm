# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_read.s                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jmaydew <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 13:55:15 by jmaydew           #+#    #+#              #
#    Updated: 2020/12/08 13:55:17 by jmaydew          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	C Function prototype: ssize_t ft_read(int fd, void *buf, size_t count)  ;
;	Expected input:	rdi = fd, rsi = buf, rdx = count                        ;
;	Expected output: rax                                                    ;
;	Clobbers:	rax, rcx                                                    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

extern  __errno_location

            global  ft_read
            section .text

ft_read:    
            xor     rax, rax            ; set rax to 0, syscall index for READ
            syscall                     ; read syscall, with arguments rdi = fd,
                                        ; rsi = buf and rdx = count
            test    rax, rax            ; set sign flag among others
            jl      error               ; if lower than 0, an error occurred
            ret                         ; else, return

error:      
            not     rax                 ; change sign of rax 1/2
            inc     rax                 ; change sign of rax 2/2
            mov     rcx, rax            ; error code into rax
            call    __errno_location    ; get address of errno
            mov     [rax], rcx          ; save error code at errno location
            mov     rax, -1             ; set rax to -1 (return value for error)
            ret                         ; return
