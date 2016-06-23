// пример ограниченности знаков чисел с плавающей сзапятой. х=х+1 
//

#include "stdafx.h"


int main()
{
	double x;
	bool yes;

	x=1e16;
    yes=(x==x+1);
	if (yes)
	    printf("x=x+1");
	else
		printf("x!=x+1");
	scanf("%f",&x);
}

