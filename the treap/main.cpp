                              //THE TREAP
//����������� ��������� �������� ��� ���������� ������

#include <iostream>
#include <stdlib.h>
#include <math.h>
#include <time.h>

using namespace std;

class treap//�������� �����
{
    public:
    int x;//����
    int y;//���������
    treap *left;//������ �� ������ �������
    treap *right;//������ �� ������� �������
    void createtreap(int X,int Y,treap *L,treap *R);//��������
    void split(int x0,treap **L,treap **R);//����������
    void bypass();//�����
};

void treap::createtreap(int X,int Y,treap *L,treap *R)//�������� ����� � ������ �, ���������� Y � ����� � ������ ��������� L,R
{
    x=X;
    y=Y;
    left=L;
    right=R;
}

void treap::split(int x0,treap **L,treap **R)//���������� ����� �� ��� � ������� ������ � ������ �0
{
    treap *newtreap=NULL;//������� ��� ������
    if (x<=x0)//���� ������� ������ �0
    {
        if (right==NULL)//���� ������ ������ ��� �� ��� ����� ������ ������ �0 � � R ����� �� �����
            *R=NULL;
        else
            right->split(x0,&newtreap,R);//� R ����� ���� �������� ������ �0. ������� �� � newtreap. ������� ����� � R
        *L=new treap;//���� ������ �����
        (*L)->createtreap(x,y,left,newtreap);//��� ������-������ ���������, � ������ ���, ��� ������ �0, �� ������ �����
    }
    else//��� ����������
    {
        if (left==NULL)
            *L=NULL;
        else
            left->split(x0,L,&newtreap);
        *R=new treap;
        (*R)->createtreap(x,y,newtreap,right);
    }
}

treap* Merge(treap *L,treap *R)//������� ���� ������ � ����
{
    if (L==NULL) return R;//���� ���� ������ ������, �� ��� � �����
    if (R==NULL) return L;//��� ��

    if (L->y>R->y)//���� ��������� ������ ����� ������ �������, �� ������ ������ ����� ������ ������
    {
        treap *newtreap=Merge(L->right,R);//������� ������ ����� ������ ��������� � ������, ��� ����� ������ ����� ������ ������
        treap *a=new treap;
        a->createtreap(L->x,L->y,L->left,newtreap);//������� ������ ������
        return a;
    }
    else//��� ����������
    {
        treap *newtreap = Merge(L,R->left);
        treap *a=new treap;
        a->createtreap(R->x,R->y,newtreap,R->right);
        return a;
    }

}


treap* add(int X,treap *a)//��������� � � ������ � � ������� �����������
{
    treap *L,*R;//��� ��� �����
    a->split(X,&L,&R);//��������� � �� 2 �� � � ������ ����� � L � R
    treap *m;
    m=new treap;

    m->createtreap(X,rand(),NULL,NULL);//������� ������ � ������ �, ��������� ����������� � ������� ���������
    return Merge(Merge(L,m),R);//������� m c L ����� ��� � R. ���
}

void treap::bypass()//������������ ����� �����
{
    if (left!=NULL)
        left->bypass();
    cout<<x<<" ";
    if (right!=NULL)
        right->bypass();
}


void RandomInput()//�������� ���� �� n ��������� �����. ��������� �������� � ������� ������
{
    cout<<"Enter amount of numbers"<<endl;
    int n;
    cin>>n;
    if (n!=0)
    {
        cout<<"Basic numbers: " ;
        treap *a;
        a=new treap;
        int num=rand();
        cout<<num<<" ";
        a->createtreap(num,rand(),NULL,NULL);
        for (int i=1;i<n;i++)
        {
            num=rand();//���������� ����
            cout<<num<<" ";//�������
            a=add(num,a);//������ � ����
        }
        cout<<endl;
        cout<<"Sort numbers: ";
        a->bypass();//�������
    }
}

void Input()//���� ������ n �����, ��� ���������� ������
{
    cout<<"Enter amount of numbers:"<<endl;
    int n;
    cin>>n;
    if (n!=0)
    {
        cout<<"Enter "<<n<<" numbers:"<<endl;
        treap *a;
        a=new treap;
        int num;
        cin>>num;
        a->createtreap(num,rand(),NULL,NULL);
        for (int i=1;i<n;i++)
        {
            cin>>num;
            a=add(num,a);
        }
        cout<<"Sort numbers: ";
        a->bypass();
    }
}


void TimeTest()//�������� ���� �� n ��������� �����. ��������� ����� ������ ����� �����
{
    cout<<"Enter amount of numbers (use big numbers):"<<endl;
    int n;
    cin>>n;
    if (n!=0)
    {
        cout<<"Please wait"<<endl;
        float Time=clock();//��������� ������� �������
        treap *a;
        a=new treap;
        a->createtreap(rand(),rand(),NULL,NULL);//������ �������
        for (int i=1;i<n;i++)//������ ����
        {
            a=add(rand(),a);
        }
        Time=(clock()-Time)/CLOCKS_PER_SEC;//������� � ������� �����
        cout<<"Time of sorting = "<<Time<<" second.";
    }
};


int main()
{
    srand(time(NULL));//�������� ��������� �������������� �����
    int menu=0;
    cout<<"                       THE TREAP"<<endl;
    cout<<"1-Sort n random numbers with help of tree"<<endl;
    cout<<"2-Enter n numbers and sort them"<<endl;
    cout<<"3-Sort n random numbers without output (time test)"<<endl;
    while ((menu<1)||(menu>3))
        cin>>menu;
    switch (menu)
    {
    case 1:
        RandomInput();
        break;
    case 2:
        Input();
        break;
    case 3:
        TimeTest();
        break;
    }
    cout<<endl;
    system("pause");
}
