#include <iostream>

using namespace std;

typedef int Ttow[4][50];

  void Input(Ttow a,int n)
  {
      int i,k;
      for (i=1;i<50;i++)
      {
          a[1][i]=0;
          a[2][i]=0;
          a[3][i]=0;
      }
      k=1;
      for(i=n;i>0;i--)
      {
          a[1][k]=i;
          k++;
      }

  };


void Shift(Ttow a,int t_from,int t_to)
{
    int i,num_to,num_from;
    i=1;
    while (a[t_from][i]!=0)
        i++;
    num_from=i-1;
    i=1;
    while (a[t_to][i]!=0)
        i++;
    num_to=i;
    a[t_to][num_to]=a[t_from][num_from];//перекладываем
    a[t_from][num_from]=0;
};

void Hanoys(Ttow a,int t_from,int t_to,int t_ext,int m,int n)
{
    if (m>0)
    {
        Hanoys(a,t_from,t_ext,t_to,m-1,n);
        Shift(a,t_from,t_to);//перекладываем нижний
        Hanoys(a,t_ext,t_to,t_from,m-1,n);
    }
}

int main()
{
    Ttow a;
    int i;
    int n;
    cin>>n;
    Input(a,n);
    Hanoys(a,1,2,3,n,n);
    cout<<"Complete";
    return 0;
}
