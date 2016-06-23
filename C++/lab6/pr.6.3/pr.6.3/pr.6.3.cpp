// pr.6.3.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

int n;

void Input(Tmtx mtx);
void Output(Tmtx mtx);
int determinant(Tmtx mtx, int i, Tarr j);


int _tmain(int argc, _TCHAR* argv[])
{
	Tmtx mtx;
	Tarr j;
	int i,k,det;

	Input(mtx);
	for(i=1;i<=n;i++)
		j[i]=true;
	cout<<determinant(mtx,0,j);


	system("pause");
}

void Input(Tmtx mtx)
{
	int i,j;
	
	cout << "Enter rang:"<<endl;
	cin >> n;
	for(i=1; i<=n; i++)
	{
		cout << "Enter "<<i<<" string"<<endl;
		for (j=1; j<=n; j++)
			cin >> mtx[i][j];
	}
}

void Output(Tmtx mtx)
{
	int i,k;

	for(i=1; i<=n; i++)
	{
		for(k=1; k<=n; k++)
			cout << mtx[i][k]<<" ";
		cout<<endl;
	}
}

int determinant(Tmtx mtx, int i, Tarr j)
{
	int k,m,deter;

	if (n-i==2)
	{
		int a1,a2,a3,a4;

		k=1;
		while (j[k]==false)
			k++;
		a1=mtx[i+1][k];
		k++;
		while (false==j[k])
			k++;
		a2=mtx[i+1][k];
		
		k=1;
		while (j[k]==false)
			k++;
		a3=mtx[i+2][k];
		k++;
		while (false==j[k])
			k++;
		a4=mtx[i+2][k];
      deter=a1*a4-a2*a3;//вычисляем определитель	
	}
	else
	{
		i++;
		deter=0;
		m=1;
		for(k=1;k<=n;k++)
		{
			if (j[k]==true)
			{
				if (m%2==1)
				{
					j[k]=false;
					deter=deter+mtx[i][k]*determinant(mtx,i,j);
					j[k]=true;
				}
				else
				{
					j[k]=false;
					deter=deter-mtx[i][k]*determinant(mtx,i,j);
					j[k]=true;
				}
				m++;
			}
		}
	}
	return deter;
}


