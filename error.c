/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   error.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dfinnis <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/22 17:04:24 by dfinnis           #+#    #+#             */
/*   Updated: 2018/12/22 17:04:27 by dfinnis          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

# include <push_swap.h>

void	ft_error(t_all *all)
{
	ft_putstr("Error\n");
	ft_free_all(all);//
	exit (1);
}

void	ft_free_stack(t_stack *stack)
{
	while ()
	{

	}
}

void	ft_free_all()
{
	ft_free_stack(a);
	ft_free_stack(b);

}
