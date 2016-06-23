// ÷едьсий-фаренгейт
//

#include "stdafx.h"

#define N 0.0001 //минимальное значение шага

int main()
{
	float down,up,step,fareng;


	printf("Enter down verge:\n");
	scanf("%f",&down);
	while (down<-273.15)
	{
		printf("Error!!!Temperature is less absolutely zero. Enter again:\n");
		scanf("%f",&down);
	}
	printf("Enter up verge:\n");
	scanf("%f",&up);
	while (up<-273.15)
	{
		printf("Error!!!Temperature is less absolutely zero. Enter again:\n");
		scanf("%f",&up);
	}
	printf("Enter step:\n");
	scanf("%f",&step);
	while ((step<N)&&(step>-N)) 
	{
		printf("Error!!! Step is little. Enter again:\n");
		scanf("%f",&step);
	}
	printf("  CELSIUS    FARENHGEIT\n");
	if (((step>0)&&(down>up))||((step<0)&&(down<up)))
		step=-step;

	if (step>0)
	{
		while (down<up)
		{
			fareng=9*down/5+32;
			printf("%10.3f %12.3f\n",down,fareng);
			down+=step;
		}
		fareng=9*up/5+32;
		printf("%10.3f %12.3f\n",up,fareng);
	}
	else
	{
		while (down>up)
		{
			fareng=9*down/5+32;
			printf("%10.3f %12.3f\n",down,fareng);
			down+=step;
		}
		fareng=9*up/5+32;
		printf("%10.3f %12.3f\n",up,fareng);
	}
	scanf("%f",&step);
}

