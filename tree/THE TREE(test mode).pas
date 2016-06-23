                                                   {THE AVL-TREE}
{Программа, предназначенная для демонстрации работы с АВЛ-деревьями. Позволяет добавлять элементы в дерево, удалять, выводить на экран дерево и т.д}

uses crt;//нужна для меню


type 
  tree=^S;//дерево
  s=record
    key:integer;//ключ(значение)
    left:tree;//ссылка на левого потомка
    right:tree;//ссылка на правого потомка
    balance:integer;//баланс вершины(по пр-пу АВЛ)
  end;




                                       {ЧАСТЬ 1. СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ}
             {В данной части описаны процедуры, в основном использующиеся другими процедурами, вызов которых(за исключениями) не дает визуальных результатов}

{МАКСИМАЛЬНАЯ ГЛУБИНА}
function depth(a:tree):integer;//функция, возвращающая максимальную глубину дерева или поддерева а
var
  l,r:integer;//глубина левого и правого поддерева
begin
  if a<>nil then
  begin
    l:=depth(a^.left);//вычисляем глубину левого поддерева
    r:=depth(a^.right);//вычисляем глубину правого поддерева
    if l>r then//берем наибольшую и прибавляем 1 для текущего дерева
      depth:=l+1
    else 
      depth:=r+1;
  end
  else
    depth:=0;//глубина пустого дерева 0
end;
{...}




{ПОВОРОТЫ}
{4 правила,именуемых поворотами, с помощью которых происходит перестроение дерева или поддерева}

procedure RightTurn(var a:tree);//малый правый поворот
  var right_child:tree;//правый потомок левого дерева
begin
  right_child:=a^.left^.right;
  a^.left^.right:=a;
  a:=a^.left;
  a^.right^.left:=right_child;
end;


procedure LeftTurn(var a:tree);//малый левый поворот
  var left_child:tree;//правый потомок правого дерева
begin
  left_child:=a^.right^.left;
  a^.right^.left:=a;
  a:=a^.right;
  a^.left^.right:=left_child;
end;


procedure BigLeftTurn(var a:tree);//Большой левый поворот-комбинация правого поворота правого поддерево и левого поворота
begin
  rightTurn(a^.right);
  LeftTurn(a);
end;


procedure BigRightTurn(var a:tree);//Большой правый поворот-комбинация левого поворота левого поддерево и правого поворота
begin
  LeftTurn(a^.left);
  RightTurn(a);
end;
{...}





{БАЛАНСИРОВКА ВЕРШИНЫ}
{Делает 1 из поворотов в зависимости от типа дисбаланса. Выполняет только 1 поворот, т.ч. применять для сильно не сбалансированных вершин бессмысленно}
procedure Balancing(var a:tree);
begin
  if (a^.Balance>1) then//перевешивает правая ветка
  begin
    if depth(a^.right^.right)>depth(a^.right^.left) then//если правая ветка правой ветки перевешивает левую ветку правой ветки, выполняем малый левый поворот,
      leftTurn(a)
    else// иначе большой левый поворот
      BigLeftTurn(a);
  end
  else
  begin
    if (a^.Balance<-1) then//перевешивает левая ветка
    begin
      if depth(a^.left^.left)>depth(a^.left^.right) then//если левая ветка левой ветки перевешивает правую ветку левой ветки, выполняем малый правый поворот,
        RightTurn(a)
      else// иначе большой правый поворот
        BigRightTurn(a);
    end;
  end;
end;
{...}


   
 

{ПОЛНАЯ БАЛАНСИРОВКА}
{Данная процедура продолжает балансировку дерева и поддеревьев до тех пор, пока дерево не станет АВЛ}
{Позволяет сделать АВЛ-дерево из любого бинарного дерева поиска, даже из линии}
{Однако, использование процедуры в программе КАТЕГОРИЧЕСКИ НЕ РЕКОМЕНДУЕТСЯ, поскольку она вместе с подпроцедурами затрачивает большое количесво выч.мощности и памяти}
{Процедура создана для тестирования других процедур}  

  procedure make_balance(var a:tree);//подпроцедура расстановки балансов для каждого узла дерева
  begin
    if a<>nil then//пока не дошли до листа
    begin
      make_balance(a^.left);//расставляем баланс левой ветки
      a^.balance:=depth(a^.right)-depth(a^.left);//баланс есть разница глубины правой ветки и левой
      make_balance(a^.right);//расставляем баланс левой ветки
    end;
  end;

 
  procedure Search_disbalance(var a,main_a:tree; var is_avl:boolean);//поиск дисбаланса в поддереве дерева main_a.is_avl показывает были ли в проходе перестановки
  begin
    if a<>nil then
    begin
      if (a^.balance<-1) or (a^.balance>1) then//узел несбалансирован
      begin
        balancing(a);//балансируем его
        is_avl:=false;//перестановка была
        make_balance(main_a);//перерасставляем балансы
      end;
      Search_disbalance(a^.left,main_a,is_avl);//ищем дисбаланс в левой ветке
      Search_disbalance(a^.right,main_a,is_avl);//ищем дисбаланс в правой ветке
    end;
  end;


procedure Main_balancing(var a:tree);//основная процедура полной балансировки
var
  is_AVL:boolean;//поазывает были ли перестановки за последний проход
begin
  make_balance(a);//расставляем балансы
  is_AVL:=true;//пока перестановок не было
  Search_disbalance(a,a,is_avl);//ищем дисбаланс в дереве
  if not is_AVL then//если были выполнены перестановки, значит дерево возможно все еще не АВЛ. Перезапустим процедуру 
    Main_balancing(a);
end;
{...} 







                                          {ЧАСТЬ 2. ОСНОВНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ}
            {Здесь описаны основные процеду, которые в основном и будут использоваться в меню}


{ФУНКЦИЯ ПОИСКА ЭЛЕМЕНТА В ДЕРЕВЕ.}

  procedure seaching_in_subtree(a:tree;root:integer;var lbl:boolean);//подпроцедура поиска root в поддереве a. Если найдено, то lbl станет true
  begin
    if a<>nil then 
    begin
      if a^.key=root then//если нашли, отмечаем это в метке
        lbl:=true
      else//если не нашли, то рекурсивно спускаемся вниз
      begin
        if a^.key>root then//если искомый корень меньше текущего, идем влево
          seaching_in_subtree(a^.left,root,lbl)
        else//если искомый корень больше текущего, идем вправо
          seaching_in_subtree(a^.right,root,lbl);
      end;
    end;
  end;

function searching(a:tree;root:integer):boolean;//функция возвращающая true, если элемент root есть в дереве а и false, если нет
var
  lbl:boolean;//метка, показывающая наличие элемента в дереве при обратном ходе рекурсии
begin
  lbl:=false;//сначала не нашли
  seaching_in_subtree(a,root,lbl);//запуск подпроцедуры
  searching:=lbl;
end;
{...}  
  



{КОЛИЧЕСТВО ЭЛЕМЕНТОВ В ДЕРЕВЕ}
{Процедура, выводящая кол-во элементов дерева}
procedure amount_of_elements(a:tree; var num:integer);//возвращает кол-во элементов дерева а в переменную num
begin
  if a<>nil then
  begin
    amount_of_elements(a^.left,num);//ищем кол-во элементов левого поддерева
    num:=num+1;//прибаввлем 1
    amount_of_elements(a^.right,num);//прибавляем кол-во элементов правого поддерева
  end;
end;
{...}




{СИММЕТРИЧНЫЙ ОБХОД ДЕРЕВА}
{Процедура, выводящая на экран все элементы дерева в порядке возрастания, обходя его} 
procedure bypass(a:tree);//обход дерева а
begin
  if a<>nil then
  begin
    bypass(a^.left);//сначала выведем все что меньше
    write(a^.key,' ');//затем себя
    bypass(a^.right);//затем все, что больше
  end;
end;
{...}




{ВСТАВКА ВЕРШИНЫ В АВЛ-ДЕРЕВО}
{Процедура добавляет элемент в дерево и автоматически устраняет возможный дисбаланс балансировкой на обратном ход рекурсии} 
procedure insert(root:integer;var a:tree);//вставка числа root в дерево a
begin
    if (a=nil) then//если мы в пустоте
      begin
      new(a);//создаем узел
      a^.key:=root;//заполняем
      a^.left:=nil;
      a^.right:=nil;
      end
    else
    begin  
      if root>a^.key then//если больше идем направо, если меньше влево
        insert(root,a^.right)
      else
        insert(root,a^.left);
      a^.balance:=depth(a^.right)-depth(a^.left);//расставляем балансы вершин, по которым шли
      balancing(a);//балансируем их
    end;
end; 
{...} 




{УДАЛЕНИЕ ЭЛЕМЕНТА ИЗ АВЛ-ДЕРЕВА}
{Процедура удаляет элемент из дерева и устраняет возможный дисбаланс балансировкой} 
{Данная процедура самая сложная. Несмотря на большое количество подпроцедур и их длину, 
процедура не затрачивает большое кол-во памяти в отличии, например, от полной балансировки. Алгоритм программы:
     1.Процедура search_for_delete ищет удаляемый элемент в дереве. (В обратном ходе рекурсии балансируются пройденные узлы.)
     2.Если нашла, то передает работу процедуре real_delete
     3.Производится удаление путем первоначальной замены, удаляемого элемента на минимальный из правой ветки,
       либо максимальный из левой, которые в свою очередь ищутся процедурами search_min и search_mаx
     4.Возвращается родитель узла, вставшего на место удаляемого
     5.Если этот родитель не пуст(это если удаляемый элемент лист или еще в ряде случаев
       процедура balancing_after_delete устраняет дисбаланс идя от этого родителя к вершине дерева путем обратного хода рекурсии}


  function search_min(a:tree; var parent:tree):tree;//поиск минимального элемента поддерева, возвращает сам узел и родителя
  begin
    if a^.left^.left<>nil then//если у левого потомка есть еще левый потомок, то спускаемся туда
      search_min:=search_min(a^.left,parent)
    else
    begin//если левый потомок лист т.е. мин-й элемент
      search_min:=a^.left;//нашли мин. элемент
      parent:=a;//нашли предка
    end;
  end;
  
  
  function search_max(a:tree; var parent:tree):tree;//поиск максимального элемента поддерева, возвращает сам узел и родителя
  begin
    if a^.right^.right<>nil then//если у правого потомка есть еще правый потомок, то спускаемся туда
      search_max:=search_max(a^.right,parent)
    else
    begin//если правый потомок лист т.е. макс-й элемент
      search_max:=a^.right;//нашли макс. элемент
      parent:=a;//нашли предка
    end;
  end;
  
  
   procedure real_delete(var a,parent:tree);//подпроцедура удаления узла поддерева а, где этот узел его корень
  begin
    if (a^.left=nil) and (a^.right=nil) then//если это лист, тупо удаляем его 
    begin
      a:=nil;
      dispose(a);
    end  
    else//если все же не лист
    begin
      if a^.right<>nil then//если справа есть потомок
      begin
        if a^.right^.left<>nil then//если этот потомок имеет потомка слева
        begin
          a^.key:=search_min(a^.right,parent)^.key;//ищем минимум и ставим его на удаляемый элемент
          parent^.left:=parent^.left^.right;//правую ветку левого потомка родителя замены перетаскиваем на левого потомка родителя. Замененный эл-т исчезает
        end
        else//если потомок справа не имеет потомков слева
        begin
          a^.key:=a^.right^.key;//возьмем значение правого потомка
          a^.right:=a^.right^.right//перепрыгнем правого потомка
        end
      end
      else//если справа нет потомков, но слева есть
      begin
        if a^.left^.right<>nil then//если этот потомок имеет потомка справа
        begin
          a^.key:=search_max(a^.left,parent)^.key;//ищем максимум и ставим его на удаляемый элемент
          parent^.right:=parent^.right^.left;//левую ветку правого потомка родителя замены перетаскиваем на правого потомка родителя. Замененный эл-т исчезает
        end
        else//
        begin//если потомок слева не имеет потомков справа
          a^.key:=a^.left^.key;//возьмем значение левого потомка
          a^.left:=a^.left^.left//перепрыгнем его
        end;
      end;
    end;
  end; 
 
 
  procedure search_for_delete(root:integer; var a,parent:tree);//поиск эл-та root в дереве а для удаления. Parent Вовращает родителя элемента, вставшего на место удаляемого, если происходил поиск мин. или мак. иначе nil
  begin
    if searching(a,root) then//если элемент есть в дереве
    begin
      if a<>nil then//если не лист
      begin
        parent:=nil;//пока замены не делалось
        if a^.key=root then//нашли 
        begin
          real_delete(a,parent);//процедура удаления
          if a<>nil then
          begin//сразу балансируем измененную вершину
            a^.balance:=depth(a^.right)-depth(a^.left);
            balancing(a);
          end;
        end
        else//пока не нашли
        begin//смотрим и слева и справа
          if root<a^.key then//если меньше идем влево
            search_for_delete(root,a^.left,parent)
          else//иначе направо
            search_for_delete(root,a^.right,parent);
          a^.balance:=depth(a^.right)-depth(a^.left);//балансируем все ветки, который прошли
          balancing(a); 
        end;
      end;
    end;
  end;


  procedure balancing_after_delete(parent:tree; var a:tree);//балансировка после удаления
  begin
  if parent<>nil then
  begin
    if (a<>nil) and (a^.key<>parent^.key) then//если пока не уткнулись в искомый узел
    begin//ищем его дальше
      if parent^.key<a^.key then
        balancing_after_delete(parent,a^.left)
      else
        balancing_after_delete(parent,a^.right);//балансируем все пройденные узлы
      a^.balance:=depth(a^.right)-depth(a^.left);
      balancing(a);
    end
    else
    begin//если нашли parent(уткнуться в пустоту, должно быть невозможно при корректном вызове процедуры) балансируем его
      a^.balance:=depth(a^.right)-depth(a^.left);
      balancing(a);
    end;
  end;
  end;


procedure delete(root:integer; var a:tree);//основная процедура, удаляет root из дерева a
var
  parent:tree;//родитель элемента, который встанет на место root
begin
  search_for_delete(root,a,parent);//ищем и удаляем
  if parent<>nil then//если производилась сложная замена, то сбалансируем дерево
    balancing_after_delete(parent,a);
end;
{...}




{ВЫВОД ДЕРЕВА НА ЭКРАН}  
{Прцедура, выводящая дерево на экран в виде дерева псевдографикой}    
procedure Print_Tree(a:tree;x,y,k:integer);//вывод на экран дерева а с вершиной в коррдинатах х и y, к-глубина узла, если это поддерево
begin
  if a<>nil then
  begin
    gotoXY(x,y);//идем куда надо
    write(a^.key);//печатаем узел
    k:=k+1;//увеличиваем глубину узла в связи с переходом
    y:=y+1;//спускаемся(можно вместо 1 поставить 2 или 3. Тогда увеличится расстояие между уровнями)
    x:=x-trunc(power(2,5-k));//ищем новую х
    print_tree(a^.left,x,y,k);//печатаем левое поддерево
    x:=x+2*trunc(power(2,5-k));//ищем новую х
    print_tree(a^.right,x,y,k);//печатаем правое поддерево
    gotoXY(1,depth(a)+5);//спускаемся по завершении
  end;
end;
{...}







                                                      {ЧАСТЬ 3. МЕНЮ}
                {Здесь описаны поцедуры, с помощью которых реализован удобный интерфейс работы с программой}
  
  
var
  a,b:tree;//наше дерево, с которым мы будем работать
  root,i,n:integer;//корень его и счетчики
begin
  TextBackground(white);
  clrscr;
  TextColor(black);
  for i:=10 to 75 do
  begin
    insert(i,a);
  end;
  for i:=20 to 55 do
    delete(i,a);

 print_tree(a,40,1,0);
 gotoxy(1,20);
 amount_of_elements(a,n);
 write(n);
end.