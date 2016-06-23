// Печатает таблицу синусов от 1 до N
//

#include "stdafx.h"

#include "math.h"

#define N 10.0


int main()
{	
	float i,sinus;
	for(i=1.0; i<=N; i++)
	{
		sinus=sin(i);
		printf("%3.0f\t %f\n",i,sinus);
	}
	scanf("%f",i);
}

