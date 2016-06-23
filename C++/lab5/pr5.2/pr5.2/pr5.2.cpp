// pr5.2.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

void enter(int *n, string *num);
string action(string number);

int _tmain(int argc, _TCHAR* argv[])
{
	int n,i;
	string number;
	
	enter(&n,&number);
	for(i=1; i<=n; i++)
		number=action(number);
	cout << "Total is " << number <<endl;
	system("echo 1234");
	system("pause");
}

void enter(int *n, string *num)
{
	cout<<"Enter amount of operation"<<endl;
	cin>>*n;
	cout<<"Enter string:"<<endl;
	cin>>*num;
}

string action(string number)
{
	int i,j;
	string act,c,b;

	i=0;
	act="";
	while (i<number.length())
	{
		c=number.substr(i,1);
		j=0;
		while (number.substr(i+j,1)==c)
			j++;
		char s[10];
		itoa(j,s,10);
		act.append(s);
		act.append(c);
		i+=j;
	}
	return act;
}

