//���������, ������� ��� ������� ����������� � ������������ �������� ������� y=ax+b+c*sin(d*x)(��� a,b,c,d ��� ��������� 4 ����� ������� �� ������ 7 "�"=1,�="2") 
//�� �������, ������� �������� �������� �������������
//����������� ������ �������� ������� �� ������� � ����� N � �� ��� ������������ ������� � ��������


#include "stdafx.h"

#include <math.h>

#define A 2
#define B 1
#define C 2
#define D 0
#define N 0.001

int _tmain(int argc, _TCHAR* argv[])
{
	float x1,x2,min,max,x,y;

	printf("Enter start of line\n");
	scanf("%f",&x1);
	printf("Enter end of line\n");
	scanf("%f",&x2);
	if (x2<x1)//���� ���������� ������� ����� ������ �������
	{	float r;

		r=x1;
		x1=x2;
		x2=r;
	}
	y=A*x1+B+C*sin((D*x1));
	max=y;
	min=y;
	for(x=x1; x<=x2; x+=N)
	{
		y=A*x+B+C*(sin(D*x));
		if (y>max)
			max=y;
		if (y<min)
			min=y;
	}
	y=A*x2+B+C*(sin(D*x2));
	if (y>max)
		max=y;
	if (y<min)
		min=y;
	printf("max(y):  %6.2f\n",max);
	printf("min(y):  %6.2f\n",min);
	scanf("%f",&x1);
	
}

