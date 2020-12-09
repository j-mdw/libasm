/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jmaydew <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/12/08 11:11:02 by jmaydew           #+#    #+#             */
/*   Updated: 2020/12/08 14:31:59 by jmaydew          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

# include <stddef.h>
# include <unistd.h>
# include <errno.h>
# include <stdlib.h>

typedef	struct	s_list
{
	void			*data;
	struct s_list	*next;
}				t_list;

size_t			ft_strlen(const char *s);
int				ft_strcmp(const char *s1, const char *s2);
char			*ft_strcpy(char *dest, const char *src);
ssize_t			ft_write(int fd, const void *buf, size_t count);
ssize_t			ft_read(int fd, void *buf, size_t count);
char			*ft_strdup(const char *s);

/*
** BONUS
*/

int				ft_atoi_base(char *str, char *base);
void			ft_list_push_front(t_list **begin_list, void *data);
int				ft_list_size(t_list *begin_list);
void			ft_list_sort(t_list **begin_list, int (*cmp)());
void			ft_list_remove_if(t_list **begin_list, void *data_ref, \
				int (*cmp)(), void (*free_fct)(void *));

#endif
