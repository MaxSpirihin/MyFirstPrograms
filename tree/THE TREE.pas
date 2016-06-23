                                                   {THE AVL-TREE}                                                         
{���������, ��������������� ��� ������������ ������ � ���-���������. ��������� ��������� �������� � ������, �������, �������� �� ����� ������ � �.�}

uses crt;//����� ��� ����


type 
  tree=^S;//������
  s=record
    key:integer;//����(��������)
    left:tree;//������ �� ������ �������
    right:tree;//������ �� ������� �������
    balance:integer;//������ �������(�� ��-�� ���)
  end;




                                       {����� 1. ��������� ��������� � �������}
             {� ������ ����� ������� ���������, � �������� �������������� ������� �����������, ����� �������(�� ������������) �� ���� ���������� �����������}

{������������ �������}
function depth(a:tree):integer;//�������, ������������ ������������ ������� ������ ��� ��������� �
var
  l,r:integer;//������� ������ � ������� ���������
begin
  if a<>nil then
  begin
    l:=depth(a^.left);//��������� ������� ������ ���������
    r:=depth(a^.right);//��������� ������� ������� ���������
    if l>r then//����� ���������� � ���������� 1 ��� �������� ������
      depth:=l+1
    else 
      depth:=r+1;
  end
  else
    depth:=0;//������� ������� ������ 0
end;
{...}




{��������}
{4 �������,��������� ����������, � ������� ������� ���������� ������������ ������ ��� ���������}

procedure RightTurn(var a:tree);//����� ������ �������
  var right_child:tree;//������ ������� ������ ������
begin
  right_child:=a^.left^.right;
  a^.left^.right:=a;
  a:=a^.left;
  a^.right^.left:=right_child;
end;


procedure LeftTurn(var a:tree);//����� ����� �������
  var left_child:tree;//������ ������� ������� ������
begin
  left_child:=a^.right^.left;
  a^.right^.left:=a;
  a:=a^.right;
  a^.left^.right:=left_child;
end;


procedure BigLeftTurn(var a:tree);//������� ����� �������-���������� ������� �������� ������� ��������� � ������ ��������
begin
  rightTurn(a^.right);
  LeftTurn(a);
end;


procedure BigRightTurn(var a:tree);//������� ������ �������-���������� ������ �������� ������ ��������� � ������� ��������
begin
  LeftTurn(a^.left);
  RightTurn(a);
end;
{...}





{������������ �������}
{������ 1 �� ��������� � ����������� �� ���� ����������. ��������� ������ 1 �������, �.�. ��������� ��� ������ �� ���������������� ������ ������������}
procedure Balancing(var a:tree);
begin
  if (a^.Balance>1) then//������������ ������ �����
  begin
    if depth(a^.right^.right)>depth(a^.right^.left) then//���� ������ ����� ������ ����� ������������ ����� ����� ������ �����, ��������� ����� ����� �������,
      leftTurn(a)
    else// ����� ������� ����� �������
      BigLeftTurn(a);
  end
  else
  begin
    if (a^.Balance<-1) then//������������ ����� �����
    begin
      if depth(a^.left^.left)>depth(a^.left^.right) then//���� ����� ����� ����� ����� ������������ ������ ����� ����� �����, ��������� ����� ������ �������,
        RightTurn(a)
      else// ����� ������� ������ �������
        BigRightTurn(a);
    end;
  end;
end;
{...}


   
 

{������ ������������}
{������ ��������� ���������� ������������ ������ � ����������� �� ��� ���, ���� ������ �� ������ ���}
{��������� ������� ���-������ �� ������ ��������� ������ ������, ���� �� �����}
{������, ������������� ��������� � ��������� ������������� �� �������������, 
��������� ��� ������ � �������������� ����������� ������� ��������� ���.�������� � ������}
{��������� ������� ��� ������������ ������ ��������}  

  procedure make_balance(var a:tree);//������������ ����������� �������� ��� ������� ���� ������
  begin
    if a<>nil then//���� �� ����� �� �����
    begin
      make_balance(a^.left);//����������� ������ ����� �����
      a^.balance:=depth(a^.right)-depth(a^.left);//������ ���� ������� ������� ������ ����� � �����
      make_balance(a^.right);//����������� ������ ������ �����
    end;
  end;

 
  procedure Search_disbalance(var a,main_a:tree; var is_avl:boolean);//����� ���������� � ��������� � ������ main_a.is_avl ���������� ���� �� � ������� ������������
  begin
    if a<>nil then
    begin
      if (a^.balance<-1) or (a^.balance>1) then//���� ���������������
      begin
        balancing(a);//����������� ���
        is_avl:=false;//������������ ����
        make_balance(main_a);//��������������� �������
      end;
      Search_disbalance(a^.left,main_a,is_avl);//���� ��������� � ����� �����
      Search_disbalance(a^.right,main_a,is_avl);//���� ��������� � ������ �����
    end;
  end;


procedure Main_balancing(var a:tree);//�������� ��������� ������ ������������
var
  is_AVL:boolean;//��������� ���� �� ������������ �� ��������� ������
begin
  make_balance(a);//����������� �������
  is_AVL:=true;//���� ������������ �� ����
  Search_disbalance(a,a,is_avl);//���� ��������� � ������
  if not is_AVL then//���� ���� ��������� ������������, ������ ������ �������� ��� ��� �� ���. ������������ ��������� 
    Main_balancing(a);
end;
{...} 







                                          {����� 2. �������� ��������� � �������}
            {����� ������� �������� �������, ������� � �������� � ����� �������������� � ����}


{������� ������ �������� � ������.}

  procedure seaching_in_subtree(a:tree;root:integer;var lbl:boolean);//������������ ������ root � ��������� a. ���� �������, �� lbl ������ true
  begin
    if a<>nil then 
    begin
      if a^.key=root then//���� �����, �������� ��� � �����
        lbl:=true
      else//���� �� �����, �� ���������� ���������� ����
      begin
        if a^.key>root then//���� ������� ������ ������ ��������, ���� �����
          seaching_in_subtree(a^.left,root,lbl)
        else//���� ������� ������ ������ ��������, ���� ������
          seaching_in_subtree(a^.right,root,lbl);
      end;
    end;
  end;

function searching(a:tree;root:integer):boolean;//������� ������������ true, ���� ������� root ���� � ������ � � false, ���� ���
var
  lbl:boolean;//�����, ������������ ������� �������� � ������ ��� �������� ���� ��������
begin
  lbl:=false;//������� �� �����
  seaching_in_subtree(a,root,lbl);//������ ������������
  searching:=lbl;
end;
{...}  
  



{���������� ��������� � ������}
{���������, ��������� ���-�� ��������� ������}
procedure amount_of_elements(a:tree; var num:integer);//���������� ���-�� ��������� ������ � � ���������� num
begin
  if a<>nil then
  begin
    amount_of_elements(a^.left,num);//���� ���-�� ��������� ������ ���������
    num:=num+1;//���������� 1
    amount_of_elements(a^.right,num);//���������� ���-�� ��������� ������� ���������
  end;
end;
{...}




{������������ ����� ������}
{���������, ��������� �� ����� ��� �������� ������ � ������� �����������, ������ ���} 
procedure bypass(a:tree);//����� ������ �
begin
  if a<>nil then
  begin
    bypass(a^.left);//������� ������� ��� ��� ������
    write(a^.key,' ');//����� ����
    bypass(a^.right);//����� ���, ��� ������
  end;
end;
{...}




{������� ������� � ���-������}
{��������� ��������� ������� � ������ � ������������� ��������� ��������� ��������� ������������� �� �������� ��� ��������} 
procedure insert(root:integer;var a:tree);//������� ����� root � ������ a
begin
    if (a=nil) then//���� �� � �������
      begin
      new(a);//������� ����
      a^.key:=root;//���������
      a^.left:=nil;
      a^.right:=nil;
      end
    else
    begin  
      if root>a^.key then//���� ������ ���� �������, ���� ������ �����
        insert(root,a^.right)
      else
        insert(root,a^.left);
      a^.balance:=depth(a^.right)-depth(a^.left);//����������� ������� ������, �� ������� ���
      balancing(a);//����������� ��
    end;
end; 
{...} 




{�������� �������� �� ���-������}
{��������� ������� ������� �� ������ � ��������� ��������� ��������� �������������} 
{������ ��������� ����� �������. �������� �� ������� ���������� ����������� � �� �����, 
��������� �� ����������� ������� ���-�� ������ � �������, ��������, �� ������ ������������. �������� ���������:
     1.��������� search_for_delete ���� ��������� ������� � ������. (� �������� ���� �������� ������������� ���������� ����.)
     2.���� �����, �� �������� ������ ��������� real_delete
     3.������������ �������� ����� �������������� ������, ���������� �������� �� ����������� �� ������ �����,
       ���� ������������ �� �����, ������� � ���� ������� ������ ����������� search_min � search_m�x
     4.������������ �������� ����, ��������� �� ����� ����������
     5.���� ���� �������� �� ����(��� ���� ��������� ������� ���� ��� ��� � ���� �������
       ��������� balancing_after_delete ��������� ��������� ��� �� ����� �������� � ������� ������ ����� ��������� ���� ��������}


  function search_min(a:tree; var parent:tree):tree;//����� ������������ �������� ���������, ���������� ��� ���� � ��������
  begin
    if a^.left^.left<>nil then//���� � ������ ������� ���� ��� ����� �������, �� ���������� ����
      search_min:=search_min(a^.left,parent)
    else
    begin//���� ����� ������� ���� �.�. ���-� �������
      search_min:=a^.left;//����� ���. �������
      parent:=a;//����� ������
    end;
  end;
  
  
  function search_max(a:tree; var parent:tree):tree;//����� ������������� �������� ���������, ���������� ��� ���� � ��������
  begin
    if a^.right^.right<>nil then//���� � ������� ������� ���� ��� ������ �������, �� ���������� ����
      search_max:=search_max(a^.right,parent)
    else
    begin//���� ������ ������� ���� �.�. ����-� �������
      search_max:=a^.right;//����� ����. �������
      parent:=a;//����� ������
    end;
  end;
  
  
   procedure real_delete(var a,parent:tree);//������������ �������� ���� ��������� �, ��� ���� ���� ��� ������
  begin
    if (a^.left=nil) and (a^.right=nil) then//���� ��� ����, ���� ������� ��� 
    begin
      a:=nil;
      dispose(a);
    end  
    else//���� ��� �� �� ����
    begin
      if a^.right<>nil then//���� ������ ���� �������
      begin
        if a^.right^.left<>nil then//���� ���� ������� ����� ������� �����
        begin
          a^.key:=search_min(a^.right,parent)^.key;//���� ������� � ������ ��� �� ��������� �������
          parent^.left:=parent^.left^.right;//������ ����� ������ ������� �������� ������ ������������� �� ������ ������� ��������. ���������� ��-� ��������
        end
        else//���� ������� ������ �� ����� �������� �����
        begin
          a^.key:=a^.right^.key;//������� �������� ������� �������
          a^.right:=a^.right^.right//����������� ������� �������
        end
      end
      else//���� ������ ��� ��������, �� ����� ����
      begin
        if a^.left^.right<>nil then//���� ���� ������� ����� ������� ������
        begin
          a^.key:=search_max(a^.left,parent)^.key;//���� �������� � ������ ��� �� ��������� �������
          parent^.right:=parent^.right^.left;//����� ����� ������� ������� �������� ������ ������������� �� ������� ������� ��������. ���������� ��-� ��������
        end
        else//
        begin//���� ������� ����� �� ����� �������� ������
          a^.key:=a^.left^.key;//������� �������� ������ �������
          a^.left:=a^.left^.left//����������� ���
        end;
      end;
    end;
  end; 
 
 
  procedure search_for_delete(root:integer; var a,parent:tree);//����� ��-�� root � ������ � ��� ��������. Parent ��������� �������� ��������, ��������� �� ����� ����������, ���� ���������� ����� ���. ��� ���. ����� nil
  begin
    if searching(a,root) then//���� ������� ���� � ������
    begin
      if a<>nil then//���� �� ����
      begin
        parent:=nil;//���� ������ �� ��������
        if a^.key=root then//����� 
        begin
          real_delete(a,parent);//��������� ��������
          if a<>nil then
          begin//����� ����������� ���������� �������
            a^.balance:=depth(a^.right)-depth(a^.left);
            balancing(a);
          end;
        end
        else//���� �� �����
        begin//������� � ����� � ������
          if root<a^.key then//���� ������ ���� �����
            search_for_delete(root,a^.left,parent)
          else//����� �������
            search_for_delete(root,a^.right,parent);
          a^.balance:=depth(a^.right)-depth(a^.left);//����������� ��� �����, ������� ������
          balancing(a); 
        end;
      end;
    end;
  end;


  procedure balancing_after_delete(parent:tree; var a:tree);//������������ ����� ��������
  begin
  if parent<>nil then
  begin
    if (a<>nil) and (a^.key<>parent^.key) then//���� ���� �� ��������� � ������� ����
    begin//���� ��� ������
      if parent^.key<a^.key then
        balancing_after_delete(parent,a^.left)
      else
        balancing_after_delete(parent,a^.right);//����������� ��� ���������� ����
      a^.balance:=depth(a^.right)-depth(a^.left);
      balancing(a);
    end
    else
    begin//���� ����� parent(��������� � �������, ������ ���� ���������� ��� ���������� ������ ���������) ����������� ���
      a^.balance:=depth(a^.right)-depth(a^.left);
      balancing(a);
    end;
  end;
  end;


procedure delete(root:integer; var a:tree);//�������� ���������, ������� root �� ������ a
var
  parent:tree;//�������� ��������, ������� ������� �� ����� root
begin
  search_for_delete(root,a,parent);//���� � �������
  if parent<>nil then//���� ������������� ������� ������, �� ������������ ������
    balancing_after_delete(parent,a);
end;
{...}




{����� ������ �� �����}  
{��������, ��������� ������ �� ����� � ���� ������ ��������������}    
procedure Print_Tree(a:tree;x,y,k:integer);//����� �� ����� ������ � � �������� � ����������� � � y, �-������� ����, ���� ��� ���������
begin
  if a<>nil then
  begin
    gotoXY(x,y);//���� ���� ����
    write(a^.key);//�������� ����
    k:=k+1;//����������� ������� ���� � ����� � ���������
    y:=y+1;//����������(����� ������ 1 ��������� 2 ��� 3. ����� ���������� ��������� ����� ��������)
    x:=x-trunc(power(2,5-k));//���� ����� �
    print_tree(a^.left,x,y,k);//�������� ����� ���������
    x:=x+2*trunc(power(2,5-k));//���� ����� �
    print_tree(a^.right,x,y,k);//�������� ������ ���������
    gotoXY(1,depth(a)+5);//���������� �� ����������
  end;
end;
{...}







                                                      {����� 3. ����}
                {����� ������� ��������, � ������� ������� ���������� ������� ��������� ������ � ����������}


procedure Main_Menu(var a:tree); forward; //����������� �������� �������� ����

{�������� �����}            
procedure make_frame;//������� ����� �� �������� @.
var
  i:integer;
begin
  textbackground(white);//������� ��� �����
  textcolor(red);//����� �������
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
 
 
 
 
{��������} 
procedure Head;//������ ��������. ����� ����� ����� ������ ����� �������.
var
  key:char;
begin
  {������� �����}
  make_frame;
  {����� ��������}
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
  {������ ������� ������}
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
    {����� �������}
    textcolor(black);
    gotoxy(5,3);
    write('Writed by');
    gotoxy(5,4);
    write('Spirikhin Maxim');
    gotoxy(5,5);
    write('NRNU MEPHI');
    gotoxy(5,6);
    write('kaf 17');
 {����� AVL}
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
  {������ ������}
    gotoxy(74,20);
    write('* *');
    gotoxy(74,21);
    write(' |');
    gotoxy(74,22);
    write('\_/');
  {������� ������� ���. ������}
    textcolor(blue);
    gotoxy(34,16);
    write('press any key');
    key:=readkey; 
end; 
{...}




{������ �� �������� ����}
procedure Menu1_Add_one_element(var a:tree);//��� ������� � ������
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
  repeat//������ �� ������ ��-�� ������������� �����
    readln(str);
    val(str,element,ercode);
  until ercode=0;
  insert(element,a);
  writeln('Complete!!! Press any key to return to main menu');
  key:=readkey;
  Main_menu(a);
end;


procedure Menu2_Add_some_element(var a:tree);//��� ��������� ��������� � ������
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
  repeat//������ �� ������ ��-�� ������������� �����
    readln(str);
    val(str,n,ercode);
  until ercode=0; 
  writeln('Enter elements through Enter key:');
  k:=0;
  while k<n do
  begin
    ercode:=1;
    repeat//������ �� ������ ��-�� ������������� �����
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


procedure Menu3_check_element(var a:tree);//��������� ������� ��������
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
  repeat//������ �� ������ ��-�� ������������� �����
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


procedure Menu4_print_tree(var a:tree);//����������� ������
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


procedure Menu5_bypass_tree(var a:tree);//������ ������
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


procedure Menu6_delete_element(var a:tree);//������� �������
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
  repeat//������ �� ������ ��-�� ������������� �����
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


procedure Menu7_Information(var a:tree);//���������� � �����
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




{�������� ����}
procedure Main_Menu(var a:tree);
var
  key:char;//������� ������
begin
  {������� ����������� ����}
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
  {��������� ������� ������� � ��������� ��������������� ���������}
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




{��������� ���������}
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

 
 
 
 
 
                                                   {�������� ����}
var
  a:tree;//���� ������, � ������� �� ����� ��������
begin 
  head;//������� ��������
  main_menu(a);//��������� ������� ����
  finish;//��������� ���������
end.