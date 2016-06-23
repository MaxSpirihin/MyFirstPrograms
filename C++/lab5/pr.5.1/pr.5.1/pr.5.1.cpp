// pr.5.1.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"


void Enter(string *str)
{
	cout<<"Enter string"<<endl;
	getline(cin,*str);
	*str=" "+*str+" ";
}

bool TestPalindrome(string wd)
{	int i;
	string backwd;
	for(i=wd.length(); i>=0; --i)
		backwd.append(wd.substr(i,1));
	return wd==backwd;
}

string SearchPalindrome(string str)
{	int i;
	string wd,palindrome;

	palindrome=" ";
	i=0;
	while (i<str.length())
	{
		if (str.substr(i,1)==" ")
		{	int j;

			j=1;
			while ((str.substr(i+j,1)!=" ")&&(i+j<str.length()))
				j++;
			wd=str.substr(i+1,j-1);
			if ((TestPalindrome(wd))&&(wd.length()>=palindrome.length()))
				palindrome=wd;
		}
		i++;
	}
	return palindrome;
}






void Output(string palindrome)
{
	if (palindrome==" ")
		cout<<"No palindrome";
	else
		cout<<"The longest Palindrome is "<<palindrome<<endl;
}
int main(int argc, _TCHAR* argv[])
{	string str,palindrome;
	bool yes;
	Enter(&str);
	palindrome=SearchPalindrome(str);
	Output(palindrome);
	system("pause");
}

