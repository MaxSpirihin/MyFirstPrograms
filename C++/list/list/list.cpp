//���������, ������������������� � ����������� ������������� �������

#include "stdafx.h"

struct list
{
	int data;
	list *next;
};

void insert(int num,list **a);
void print(list *a);

int main(int argc, _TCHAR* argv[])
{
	list *a;
	a=NULL;
	insert(2,&a);
	insert(1,&a);
	insert(8,&a);
	print(a);
}

void insert(int num,list **a)
{
	list *b=*a;

	if (b==NULL)//������ ��������� ����
	{
		b=new list;
		b->data=num;
		b->next=NULL;
	}
	else
	{
		if (b->data>num)//���� ����������� ������� ������ ���� � ������
		{
			list *ext=new list;
			ext->data=num;
			ext->next=b;
			b=ext;
		}
		else
		{
			list *head=b;

			while((b!=NULL)&&(num>b->data))
				b=b->next;

			if (NULL==b)//���� ����������� ������� ������ ���� � ������
			{
				b=new list;
				b->data=num;
				b->next=NULL;
			}
			else//������ ���-�� ������
			{
				list *ext=new list;
				ext->data=num;
				ext->next=b->next;
				b->next=ext;
			}
			b=head;
		}
	}
	*a=b;
}

void print(list *a)
{
	while (a!=NULL)
	{
		cout<<a->data<<" ";
		a=a->next;
	}
	cout<<endl;
}
