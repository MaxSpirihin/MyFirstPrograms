// {Программа, которя определяет, лежит ли точка, координаты которой вводятся пользователем, 
//выше или ниже функции y=ax+b+c*sin(d*x), где a,b,c,d это последние 4 буквы фамилии по модулю 7 "а"=1,б="2"}
//

#include "stdafx.h"

#include <math.h>

#define A 2
#define B 1
#define C 2
#define D 1
int _tmain(int argc, _TCHAR* argv[])
{
	double x,y,y_from_x;

	printf("Enter x coordinate\n");
	scanf("%f",&x);
	printf("Enter y coordinate\n");
	scanf("%f",&y);
	y_from_x=A*x+B+C*sin(D*x);
	if (y_from_x==y)
		printf("Point is in funtion\n");
	else
	{
		if (y_from_x>y)
			printf("Point is down funtion\n");
		else
			printf("Point is higher funtion\n");
	}
	scanf("%f",&y);
}

