                              //THE TREAP
//реализуетс€ структура дерамида дл€ сортировки данных

#include <iostream>
#include <stdlib.h>
#include <math.h>
#include <time.h>

using namespace std;

class treap//основной класс
{
    public:
    int x;//ключ
    int y;//приоритет
    treap *left;//ссылка на левого потомка
    treap *right;//ссылка на правого потомка
    void createtreap(int X,int Y,treap *L,treap *R);//создание
    void split(int x0,treap **L,treap **R);//разрезание
    void bypass();//обход
};

void treap::createtreap(int X,int Y,treap *L,treap *R)//создание корн€ с ключом ’, приоитетом Y и левым и правым потомками L,R
{
    x=X;
    y=Y;
    left=L;
    right=R;
}

void treap::split(int x0,treap **L,treap **R)//разрезание корн€ на два с ключами меньше и больше х0
{
    treap *newtreap=NULL;//создаем доп корень
    if (x<=x0)//если вершина меньше х0
    {
        if (right==NULL)//если справа ничего нет то все ключи дерева меньше х0 и в R ичего не будет
            *R=NULL;
        else
            right->split(x0,&newtreap,R);//в R могут быть элементы меньше х0. ¬ытащим их в newtreap. ќстаток будет в R
        *L=new treap;//даем левому место
        (*L)->createtreap(x,y,left,newtreap);//его корень-корень исходного, а справа все, что меньше х0, но больше корн€
    }
    else//все аналогично
    {
        if (left==NULL)
            *L=NULL;
        else
            left->split(x0,L,&newtreap);
        *R=new treap;
        (*R)->createtreap(x,y,newtreap,right);
    }
}

treap* Merge(treap *L,treap *R)//сли€ние двух корней в один
{
    if (L==NULL) return R;//если есть только правое, то его и берем
    if (R==NULL) return L;//так же

    if (L->y>R->y)//если приоритет левого корн€ больше правого, то корень левого будет корнем нового
    {
        treap *newtreap=Merge(L->right,R);//сливаем правую ветку левого поддерева и правый, это будет права€ ветка нового дерева
        treap *a=new treap;
        a->createtreap(L->x,L->y,L->left,newtreap);//создаем нужное дерево
        return a;
    }
    else//все аналогично
    {
        treap *newtreap = Merge(L,R->left);
        treap *a=new treap;
        a->createtreap(R->x,R->y,newtreap,R->right);
        return a;
    }

}


treap* add(int X,treap *a)//добавлние ’ в дерево а и возврат полученного
{
    treap *L,*R;//два доп корн€
    a->split(X,&L,&R);//разрезаем а на 2 по х и пихаем новые в L и R
    treap *m;
    m=new treap;

    m->createtreap(X,rand(),NULL,NULL);//создаем корень с ключом ’, рандомным приоритетом и пустыми потомками
    return Merge(Merge(L,m),R);//сливаем m c L затем это с R. ¬се
}

void treap::bypass()//симметричный обход трипа
{
    if (left!=NULL)
        left->bypass();
    cout<<x<<" ";
    if (right!=NULL)
        right->bypass();
}


void RandomInput()//строитс€ трип из n рандомных чисел. вывод€тс€ исходные и готовые данные
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
            num=rand();//генерируем исло
            cout<<num<<" ";//выводим
            a=add(num,a);//пихаем в трип
        }
        cout<<endl;
        cout<<"Sort numbers: ";
        a->bypass();//выводим
    }
}

void Input()//юзер вводит n чисел, они сортируют€ трипом
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


void TimeTest()//строитс€ трип из n рандомных чисел. ¬ыводитс€ врем€ работы этого куска
{
    cout<<"Enter amount of numbers (use big numbers):"<<endl;
    int n;
    cin>>n;
    if (n!=0)
    {
        cout<<"Please wait"<<endl;
        float Time=clock();//запускаем счетчик времени
        treap *a;
        a=new treap;
        a->createtreap(rand(),rand(),NULL,NULL);//перва€ вершина
        for (int i=1;i<n;i++)//строим трип
        {
            a=add(rand(),a);
        }
        Time=(clock()-Time)/CLOCKS_PER_SEC;//считаем и выводим врем€
        cout<<"Time of sorting = "<<Time<<" second.";
    }
};


int main()
{
    srand(time(NULL));//включаем генератор псевдослучаных чисел
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
