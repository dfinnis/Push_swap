/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dfinnis <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/23 13:19:49 by dfinnis           #+#    #+#             */
/*   Updated: 2018/12/23 13:19:51 by dfinnis          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

# include "push_swap.h"

t_all	*ft_initialize(t_all *all)
{
	if (!(all = (t_all *)malloc(sizeof(t_all))))
		exit(1);
	all->a = NULL;
	all->b = NULL;
	all->v = 0;
	return (all);
}

void	ft_fill_a(t_all *all, char **argv)
{
	int	i;
	int	n;

	i = 1;
	n = 0;
	if (ft_strcmp(argv[i], "-v") == 0)
	{
		all->v = 1;
		i++;
	}
	while (argv[i])
	{
		n = ft_atoi_error(argv[i]);
		if (ft_is_duplicate(all, n))
			ft_error(all);
		ft_add_end(all, n);
		i++;
	}
}

void	ft_ko_ok(t_all *all)
{
	if (ft_is_sorted(all))
		ft_putstr("OK\n");
	else
		ft_putstr("KO\n");
}

int		ft_is_sorted(t_all *all)
{
	t_stack	*tmp;

	if (!all->a || all->b)
		return (0);
	tmp = all->a;
	while (tmp->next != all->a)
	{
		if (tmp->n > tmp->next->n)
			return (0);
		tmp = tmp->next;
	}
	return (1);
}

void	ft_add_end(t_all *all, int n)
{
	t_stack	**top;
	t_stack	*tmp;

	top = &all->a;
	if (*top)
	{
		if (!(tmp = (t_stack *)malloc(sizeof(t_stack))))
			ft_error(/*all*/);
		tmp->next = *top;
		tmp->prev = (*top)->prev;
		(*top)->prev = tmp;
		tmp->prev->next = tmp;
		tmp->n = n;
	}
	else
	{
		if (!(*top = (t_stack *)malloc(sizeof(t_stack))))
			ft_error(/*all*/);
		(*top)->next = *top;
		(*top)->prev = *top;
		(*top)->n = n;
	}
}

void	ft_add_top(t_all *all, char stack, int n)
{
	t_stack	**top;
	t_stack	*tmp;

	top = (stack == 'a') ? &all->a : &all->b;
	if (*top)
	{
		if (!(tmp = (t_stack *)malloc(sizeof(t_stack))))
			ft_error(/*all*/);
		tmp->next = *top;
		tmp->prev = (*top)->prev;
		(*top)->prev = tmp;
		tmp->prev->next = tmp;
		tmp->n = n;
		*top = (*top)->prev;
	}
	else
	{
		if (!(*top = (t_stack *)malloc(sizeof(t_stack))))
			ft_error(/*all*/);
		(*top)->next = *top;
		(*top)->prev = *top;
		(*top)->n = n;
	}
}

void	ft_del_top(t_all *all, char stack)
{
	t_stack	**top;
	t_stack	*tmp;

	top = (stack == 'a') ? &all->a : &all->b;
	if (*top)
	{
		if ((*top)->next == *top)
		{
			free(*top);
			*top = NULL;
		}
		else
		{
			tmp = *top;
			*top = (*top)->next;
			tmp->prev->next = *top;
			(*top)->prev = tmp->prev;
			free(tmp);
		}
	}
}
