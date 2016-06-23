// Пример прграммы, где a+b+c<>a+(b+c). а=-b и это большие числа.
//

#include "stdafx.h"


int _tmain(int argc, _TCHAR* argv[])
{
	double a,b,c;
	bool yes;

	a=1e16;
	b=-1e16;
	c=1;
	yes=(a+b+c==a+(b+c));
	if (yes)
		printf("a+b+c=a+(b+c)");
	else
		printf("a+b+c!=a+(b+c)");
	scanf("%f",&a);
}

