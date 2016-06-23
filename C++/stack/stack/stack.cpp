// stack.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

struct stack
{
	int data;
	stack* next;
};

void insert(int num,stack **a)
{		
	if (a==NULL)
	{
		stack *b=new stack;
		b->data=num;
		b->next=NULL;
		*a=b;
	}
	else
	{
		stack *b=new stack;
		b->data=num;
		b->next=*a;
		*a=b;	
	}
}

void print(stack *a)
{
	while (a!=NULL)
	{
		cout<<a->data<<"  ";
		a=a->next;
	}
}

int pop(stack **a)
{
	stack *b;
	b=*a;
	*a=b->next;
	int tmp=b->data;
	delete(b);
	return tmp;
}
	

int _tmain(int argc, _TCHAR* argv[])
{
	stack *a=new stack;
	a=NULL;
	for (int i=1; i<=10; i++)
		insert(i,&a);
	int k=pop(&a);
	print(a);
	cout << k  <<endl;
	system("pause");
}

