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
{������, ������������� ��������� � ��������� ������������� �� �������������, ��������� ��� ������ � �������������� ����������� ������� ��������� ���.�������� � ������}
{��������� ������� ��� ������������ ������ ��������}  

  procedure make_balance(var a:tree);//������������ ����������� �������� ��� ������� ���� ������
  begin
    if a<>nil then//���� �� ����� �� �����
    begin
      make_balance(a^.left);//����������� ������ ����� �����
      a^.balance:=depth(a^.right)-depth(a^.left);//������ ���� ������� ������� ������ ����� � �����
      make_balance(a^.right);//����������� ������ ����� �����
    end;
  end;

 
  procedure Search_disbalance(var a,main_a:tree; var is_avl:boolean);//����� ���������� � ��������� ������ main_a.is_avl ���������� ���� �� � ������� ������������
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
  
  
var
  a,b:tree;//���� ������, � ������� �� ����� ��������
  root,i,n:integer;//������ ��� � ��������
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