# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strlen.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jmaydew <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 13:56:02 by jmaydew           #+#    #+#              #
#    Updated: 2020/12/08 13:56:05 by jmaydew          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	C Function prototype: size_t ft_strlen(char *s)				;
;	Expected input:	rdi = s										;
;	Expected output: rax										;
;	Clobbers:	rax, rcx										;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

            global    ft_strlen
            section   .text
ft_strlen: 
        	xor     rcx, rcx				; set rcx to 0
        	xor     rax, rax				; set rax to 0

len_loop:	cmp		byte [rdi + rcx], al	; is byte at s + rcx == 0?
			jz      end						; if so, end of string reached
			inc		rcx						; add 1 to rcx
			jmp		len_loop				; loop

end:    	mov     rax, rcx				; set rax to rcx
        	ret								; return
