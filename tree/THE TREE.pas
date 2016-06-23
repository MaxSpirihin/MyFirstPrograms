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
{Однако, использование процедуры в программе КАТЕГОРИЧЕСКИ НЕ РЕКОМЕНДУЕТСЯ, 
поскольку она вместе с подпроцедурами затрачивает большое количесво выч.мощности и памяти}
{Процедура создана для тестирования других процедур}  

  procedure make_balance(var a:tree);//подпроцедура расстановки балансов для каждого узла дерева
  begin
    if a<>nil then//пока не дошли до листа
    begin
      make_balance(a^.left);//расставляем баланс левой ветки
      a^.balance:=depth(a^.right)-depth(a^.left);//баланс есть разница глубины правой ветки и левой
      make_balance(a^.right);//расставляем баланс правой ветки
    end;
  end;

 
  procedure Search_disbalance(var a,main_a:tree; var is_avl:boolean);//поиск дисбаланса в поддереве а дерева main_a.is_avl показывает были ли в проходе перестановки
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


procedure Main_Menu(var a:tree); forward; //опережающее описание главного меню

{СОЗДАНИЕ РАМКИ}            
procedure make_frame;//создает рамку из символов @.
var
  i:integer;
begin
  textbackground(white);//сделаем фон белым
  textcolor(red);//рамку красным
  clrscr;
  for i:=1 to 80 do
    write('@');
  for i:=2 to 23 do
  begin
    gotoxy(1,i);
    write('@');
    gotoxy(80,i);
    write('@');
  end;
  gotoxy(2,30);
  for i:=1 to 80 do
    write('@');
end;
{...}
 
 
 
 
{ЗАСТАВКА} 
procedure Head;//рисует заставку. Чтобы выйти нужно нажать любую клавишу.
var
  key:char;
begin
  {создаем рамку}
  make_frame;
  {Пишем название}
    gotoxy(32,5);
    write('----- |  | ----');
    gotoxy(32,6);
    write('  |   |  | |');
    gotoxy(32,7);
    write('  |   |--| |---');
    gotoxy(32,8);
    write('  |   |  | |');
    gotoxy(32,9);
    write('  |   |  | ----');
    gotoxy(30,10);
    write('----- --- ---- ----');
    gotoxy(30,11);
    write('  |   | | |    |');
    gotoxy(30,12);
    write('  |   |-- |--- |---');
    gotoxy(30,13);
    write('  |   |\  |    |');
    gotoxy(30,14);
    write('  |   | \ ---- ----');
    textcolor(green);
  {Рисуем деревце справа}
    gotoxy(60,3);
    write('       |');
    gotoxy(60,4);
    write('       5');
    gotoxy(60,5);
    write('      / \');
    gotoxy(60,6);
    write('     /   \');
    gotoxy(60,7);
    write('    3     7');
    gotoxy(60,8);
    write('   / \   / \');
    gotoxy(60,9);
    write('  2   4 6   9');
    gotoxy(60,10);
    write(' / \       / \');
    gotoxy(60,11);
    write('0   1     8   10');
    {слева надпись}
    textcolor(black);
    gotoxy(5,3);
    write('Writed by');
    gotoxy(5,4);
    write('Spirikhin Maxim');
    gotoxy(5,5);
    write('NRNU MEPHI');
    gotoxy(5,6);
    write('kaf 17');
 {Пишем AVL}
    gotoxy(3,12);
    write('   /\');
    gotoxy(3,13);
    write('  /  \');
    gotoxy(3,14);
    write(' /----\');
    gotoxy(3,15);
    write('/      \');
    gotoxy(7,16);
    write('\      /');
    gotoxy(7,17);
    write(' \    /');
    gotoxy(7,18);
    write('  \  /');
    gotoxy(7,19);
    write('   \/');
    gotoxy(14,18);
    write('|');
    gotoxy(14,19);
    write('|');
    gotoxy(14,20);
    write('|');
    gotoxy(14,21);
    write('|___');
  {Рисуем рожицу}
    gotoxy(74,20);
    write('* *');
    gotoxy(74,21);
    write(' |');
    gotoxy(74,22);
    write('\_/');
  {Надпись нажмите люб. кнопку}
    textcolor(blue);
    gotoxy(34,16);
    write('press any key');
    key:=readkey; 
end; 
{...}




{ВЫЗОВЫ ИЗ ГЛАВНОГО МЕНЮ}
procedure Menu1_Add_one_element(var a:tree);//доб элемент в дерево
var
  key:char;
  element,ercode:integer;
  str:string;
begin
  clrscr;
  textcolor(black);
  gotoxy(20,1);
  writeln('Enter element, which you want add to tree');
  ercode:=1;
  repeat//защита от ошибок из-за некорректного ввода
    readln(str);
    val(str,element,ercode);
  until ercode=0;
  insert(element,a);
  writeln('Complete!!! Press any key to return to main menu');
  key:=readkey;
  Main_menu(a);
end;


procedure Menu2_Add_some_element(var a:tree);//доб несколько элементов в дерево
var
  str:string;
  ercode,n,element,k:integer;
  key:char;
begin
  clrscr;
  textcolor(black);
  gotoxy(20,3);
  writeln('Enter amount of element, which you want add to tree');
  ercode:=1;
  repeat//защита от ошибок из-за некорректного ввода
    readln(str);
    val(str,n,ercode);
  until ercode=0; 
  writeln('Enter elements through Enter key:');
  k:=0;
  while k<n do
  begin
    ercode:=1;
    repeat//защита от ошибок из-за некорректного ввода
      readln(str);
      val(str,element,ercode);
    until ercode=0;
    insert(element,a);
    k:=k+1;
  end;
  
  writeln('Complete!!! Press any key to return to main menu');
  key:=readkey;
  Main_menu(a);
end;


procedure Menu3_check_element(var a:tree);//проверить наличие элемента
var
  key:char;
  element,ercode:integer;
  str:string;
begin
  clrscr;
  textcolor(black);
  gotoxy(20,1);
  writeln('Enter element');
  ercode:=1;
  repeat//защита от ошибок из-за некорректного ввода
    readln(str);
    val(str,element,ercode);
  until ercode=0;
  gotoxy(20,10);
  if searching(a,element) then
    write('YES!!!',element,' is in the tree')
  else
    write('NO!!!',element,' is not in the tree');
  gotoxy(20,20);
  writeln('Press any key to return to main menu');
  key:=readkey;
  Main_menu(a);
end;


procedure Menu4_print_tree(var a:tree);//распечатать дерево
var
  key:char;
begin
  make_frame;
  textcolor(black);
  gotoxy(30,3);
  writeln('LOOK TO YOUR TREE');
  print_tree(a,40,5,0);
  gotoxy(20,20);
  writeln('Press any key to return to main menu');
  key:=readkey;
  Main_menu(a);
end;


procedure Menu5_bypass_tree(var a:tree);//обойти дерево
var
  key:char;
begin
  make_frame;
  textcolor(black);
  gotoxy(30,3);
  writeln('There are all element on tree');
  gotoxy(4,5);
  bypass(a);
  gotoxy(20,20);
  writeln('Press any key to return to main menu');
  key:=readkey;
  Main_menu(a);
end;


procedure Menu6_delete_element(var a:tree);//удалить элемент
var
  key:char;
  element,ercode:integer;
  str:string;
begin
  clrscr;
  textcolor(black);
  gotoxy(20,1);
  writeln('Enter element, which you want delete from tree');
  ercode:=1;
  repeat//защита от ошибок из-за некорректного ввода
    readln(str);
    val(str,element,ercode);
  until ercode=0;
  if searching(a,element) then
  begin
    delete(element,a);
    writeln('Complete!!! Press any key to return to main menu')
  end
  else
    writeln(element,' is not in the tree. Press any key to return to main menu');
    key:=readkey;
    Main_menu(a);
end;


procedure Menu7_Information(var a:tree);//информация о проге
var
  key:char;
begin
  textbackground(black);
  textcolor(red);
  clrscr;
  gotoxy(25,2);
  write('The program "The Tree"');
  textcolor(white);
  gotoxy(3,4);
  write('This program designed to showcase the work AVL trees in pascal.');
  gotoxy(3,5);
  writeln('It allows you to perform all basic operations with AVL-trees,');
  gotoxy(3,6);
  writeln('such as inserting an item, display the tree, removing an item, etc.');
  gotoxy(3,7);
  writeln('It is not recommended to attempt to introduce a lot of elements in the tree');
  gotoxy(3,8);
  writeln('and display them on the screen. may be a problem');
  gotoxy(3,11);
  writeln('The program are developed by Spirikhin Maxim');
  gotoxy(3,12);
  writeln('Start development:8.10.13      Finish:20.10.13');
  gotoxy(20,17);
  write('Press any key to return to main menu');
  gotoxy(30,23);
  textcolor(red);
  write('Mephi 2013');
  key:=readkey;
  Main_menu(a);
end;
{...}  




{ОСНОВНОЕ МЕНЮ}
procedure Main_Menu(var a:tree);
var
  key:char;//нажатая кнопка
begin
  {Создаем графическое меню}
    make_frame;
    textcolor(red);
    gotoxy(36,3);
    write('THE TREE');
    textcolor(black);
    gotoxy(15,5);
    write('Welcome to the program "The tree"');
    gotoxy(3,7);
    write('Choose one from following actions and press appropriate key');
     gotoxy(65,2);
    write('Writed by');
    gotoxy(65,3);
    write('Spirikhin Maxim');
    gotoXY(65,4);
    write('NRNU MEPHI');
    gotoXY(65,5);
    write('kaf 17');
    textcolor(blue);
    gotoxy(4,9);
    writeln('1-Add one element to tree');
    gotoxy(4,11);
    writeln('2-Add some element to tree');
    gotoxy(4,13);
    writeln('3-Check availability element in tree');
    gotoxy(4,15);
    writeln('4-Print tree');
    gotoxy(4,17);
    writeln('5-Print all element of tree ascending');
    gotoxy(4,19);
    writeln('6-delete element from tree'); 
    gotoxy(4,21);
    writeln('7-show information about program'); 
    gotoxy(4,23);
    writeln('Press any another key to exit');  
  {Считываем нажатую клавишу и запускаем соответствующую процедуру}
  key:=readkey;
  case key of
    '1':Menu1_Add_one_element(a);
    '2':Menu2_Add_some_element(a);
    '3':Menu3_check_element(a);
    '4':Menu4_print_tree(a);
    '5':Menu5_bypass_tree(a);
    '6':Menu6_delete_element(a);
    '7':Menu7_Information(a);
  end;
end;
{...}




{ОКОНЧАНИЕ ПРОГРАММЫ}
procedure finish;
begin
  make_frame;
  textcolor(black);
  gotoxy(30,10);
  write('GOOD BYE');
  gotoxy(30,20);
  textcolor(red);
  write('Mephi 2013');
  gotoxy(15,15);
end;
{...}

 
 
 
 
 
                                                   {ОСНОВНОЕ ТЕЛО}
var
  a:tree;//наше дерево, с которым мы будем работать
begin 
  head;//выводим заставку
  main_menu(a);//зпаускаем главное меню
  finish;//окончание программы
end.