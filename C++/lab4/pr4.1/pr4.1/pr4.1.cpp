// {РЕШЕНИЕ КВАДРАТНОГО УРАВНЕНИЯ}
//{Данная программа предназначена для нахождения корней квадратного уравнения}


#include "stdafx.h"
#include <math.h>

#define INF_ROOTS 3
#define TEST 0

void InputVars(float *a,float *b,float *c);
void showroots(int nroots, float x1,float x2);
int SolveSqrEq(float a,float b,float c, float *xq, float *x2);

int _tmain(int argc, _TCHAR* argv[])
{
	float a,b,c;
	float x1,x2;
	int nroots;

	InputVars(&a,&b,&c);
	nroots=SolveSqrEq(a,b,c,&x1,&x2);
	showroots(nroots,x1,x2);
	scanf("%f",&a);
}

void InputVars(float *a,float *b,float *c)
{
	printf("Quadratic equation of the form ax^2+bx+c\n");
	printf("Enter a\n");
	scanf("%f",&*a);
	printf("Enter b\n");
	scanf("%f",&*b);
	printf("Enter c\n");
	scanf("%f",&*c);
}

void showroots(int nroots, float x1,float x2)
{
	switch (nroots) 
	{
		case 0:
			printf("No solution\n");
			break;
		case 1:
			printf("single solution x= %7.5f\n",x1);
			break;
		case 2:
			printf("Two solution x1=%7.5f, x2=%7.5f\n",x1,x2);
			break;
		case INF_ROOTS:
			printf("X belongs R\n");
			break;
		default:
			printf("Error\n");
	}
}

int SolveSqrEq(float a,float b,float c, float *x1, float *x2)
{
	float D;
	int r;

	if (0==a)
	{
		if (0==b)
		{
			if (0==c)
				r=INF_ROOTS;
			else
				r=0;
		}
		else
		{
			*x1=-c/b;
			r=1;
		}
	}
	else
	{
		D=b*b-4*a*c;
		if (0>D)
			r=0;
		else
		{
			if (0==D)
			{
				*x1=-b/(2*a);
				r=1;
			}
			else
			{
				r=2;
				*x1=(-b-sqrt(D))/(2*a);
				*x2=(-b+sqrt(D))/(2*a);
			}
		}
	}
	return r;
}
  
