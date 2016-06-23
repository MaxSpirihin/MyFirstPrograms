// files.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"


int _tmain(int argc, _TCHAR* argv[])
{
	int i=64354;
	freopen("1.txt","r",stdout);
	cout << i;
	fclose(stdout);
	system("pause");
	return 0;
}

