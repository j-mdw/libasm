;# **************************************************************************** #
;#																			   #
;#														  :::	   ::::::::    #
;#	 ft_strcmp.s										:+:		 :+:	:+:    #
;#													  +:+ +:+		  +:+	   #
;#	 By: jmaydew <marvin@42.fr>						+#+  +:+	   +#+		   #
;#												  +#+#+#+#+#+	+#+			   #
;#	 Created: 2020/12/08 13:55:27 by jmaydew		   #+#	  #+#			   #
;#	 Updated: 2020/12/08 21:34:54 by jmaydew		  ###	########.fr		   #
;#																			   #
;# **************************************************************************** #

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	C Function prototype: int ft_strcmp(const char *s1, const char *s2)		;
;	Expected input:	rdi = s1, rsi = s2										;
;	Expected output: rax													;
;	Clobbers:	rax, rcx, rdx												;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

			global	ft_strcmp
			section .text

ft_strcmp:	xor		rax, rax				; set rax to 0
			xor		rcx, rcx				; set rcx to 0

compare:	mov		al, byte [rdi + rcx]	; load s1 +rcx char into al
			cmp		al, byte [rsi + rcx]	; compare s1 + rcx to s2 + rcx
			jnz		unequal					; != 0
			cmp		ah, al					; compare s1 + rcx to 0
			jz		end_func				; here we know that s1[i] == s2[i] so \
											; if s1[i] == 0, s2[i] == 0
			inc		rcx						; rcx += 1
			jmp		compare					; loop

unequal:	xor		rdx, rdx
			mov		dl, byte [rsi + rcx]
			sub		eax, edx	; subtract s2 + rcx from s1 + rcx

end_func:	ret							  	; return
