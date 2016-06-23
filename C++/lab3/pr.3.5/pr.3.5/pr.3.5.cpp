// {Программа вычисляющая значение синуса угла, введенного в градусах
//Угол переволится в радианы, затем используется стандартная функция sin

#include "stdafx.h"

#include <math.h>

int main(int argc, _TCHAR* argv[])
{	float x,sinus;

	printf("Enter angle\n");
	scanf("%f",&x);
	sinus=sin(x*3.1415926535897932384626433832795/180.0);
	printf("sin(");
	printf("%.0f",x);
	printf(")=");
	printf("%f",sinus);
	scanf("%f",&x);
}

