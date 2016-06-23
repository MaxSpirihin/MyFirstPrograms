
#include "stdafx.h"

void filing(Tsymbol table);
void output(Tsymbol table);

int _tmain(int argc, _TCHAR* argv[])
{
	Tsymbol table;

	cout << "Enter string"<<endl;
	filing(table);
	output(table);
	system("pause");
}

void output(Tsymbol table)
{
	int i,j;
	char c;
	for(i=14;i<=255;i++)
	{
		c=i;
		if (table[i]!=0)
		{
			cout << c;
			for (j=1; j<=table[i]; j++)
				cout << " *";
			cout<<endl;
		}
	}
}

void filing(Tsymbol table)
{
	int i,j;

	for (i=0;i<=255;i++)
		table[i]=0;
	i=getch();
	cout<<(char)i;
	table[i]++;
	while (i!=13)
	{
		i=getch();
		cout<<(char)i;
		table[i]+=1;
	}
	cout<<endl;
}
