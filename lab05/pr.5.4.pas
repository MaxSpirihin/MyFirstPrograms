                                        {ЧИСЛА СЛОВАМИ}
{Программа выводит как произносится введенное целое число}
type
  Tten=0..10;//тип для цифр
  Tbig=string;//тип вводимого числа

procedure Input(var num,num_wihtout_changes:tbig);//ввод числа
begin
  writeln('Enter number without spaces:');
  read(num);
  num_wihtout_changes:=num;//в дальнейшем число будет изменяться в процессе. Для вывода запишем его первоначальный вид в отдельную переменную
  if length(num) mod 3<> 0 then//мы будем обрабатывать по 3 символа, поэтому если кол-во символов не кратно трем, добавим в начало нулей
  begin
    if length(num) mod 3=1 then
      num:='00'+num
    else
      num:='0'+num;
  end;
end;

procedure Output(Num_in_words,num_wihtout_changes:string;lbl:boolean);//вывод
begin
  if lbl then//метка показывает наличие ошибок ввода
    writeln('Incorrect Input. Error!!!')
  else
  begin
    writeln(num_wihtout_changes,' is read in Russian as');
    writeln(Num_in_words);
  end;
end;

function Translation_of_3(num:integer;var code:Tten):string;//перевод в строку трехзначного числа
var
  num_hun,num_ten,num_one:Tten;//число сотен, число десятков, число единиц
  Num_in_words:string;
begin
  Num_in_words:='';
  num_one:=num mod 10;
  num_ten:=(num div 10) mod 10;
  num_hun:=num div 100;
  case num_hun of
    1:Num_in_words:=Num_in_words+'сто ';
    2:Num_in_words:=Num_in_words+'двести ';
    3:Num_in_words:=Num_in_words+'триста ';
    4:Num_in_words:=Num_in_words+'четыреста ';
    5:Num_in_words:=Num_in_words+'пятьсот ';
    6:Num_in_words:=Num_in_words+'шестьсот ';
    7:Num_in_words:=Num_in_words+'семьсот ';
    8:Num_in_words:=Num_in_words+'восемьсот ';
    9:Num_in_words:=Num_in_words+'девятьсот ';
  end;
  if num_ten=1 then
  begin
    case num_one of
      0:Num_in_words:=Num_in_words+'десять ';
      1:Num_in_words:=Num_in_words+'одиннадцать ';
      2:Num_in_words:=Num_in_words+'двенадцать ';
      3:Num_in_words:=Num_in_words+'тринадцать ';
      4:Num_in_words:=Num_in_words+'четырнадцать ';
      5:Num_in_words:=Num_in_words+'пятнадцать ';
      6:Num_in_words:=Num_in_words+'шестнадцать ';
      7:Num_in_words:=Num_in_words+'семнадцать ';
      8:Num_in_words:=Num_in_words+'восемнадцать ';
      9:Num_in_words:=Num_in_words+'девятнадцать ';
    end;
  end
  else
  begin
    case num_ten of
      2:Num_in_words:=Num_in_words+'двадцать ';
      3:Num_in_words:=Num_in_words+'тридцать ';
      4:Num_in_words:=Num_in_words+'сорок ';
      5:Num_in_words:=Num_in_words+'пятьдесят ';
      6:Num_in_words:=Num_in_words+'шестьдесят ';
      7:Num_in_words:=Num_in_words+'семьдесят ';
      8:Num_in_words:=Num_in_words+'восемьдесят ';
      9:Num_in_words:=Num_in_words+'девяносто ';
    end;
    case num_one of
      1:Num_in_words:=Num_in_words+'один ';
      2:Num_in_words:=Num_in_words+'два ';
      3:Num_in_words:=Num_in_words+'три ';
      4:Num_in_words:=Num_in_words+'четыре ';
      5:Num_in_words:=Num_in_words+'пять ';
      6:Num_in_words:=Num_in_words+'шесть ';
      7:Num_in_words:=Num_in_words+'семь ';
      8:Num_in_words:=Num_in_words+'восемь ';
      9:Num_in_words:=Num_in_words+'девять ';
    end;
  end;
  if num_ten=1 then//в переменную код забиваем последнее число или 10,если имеем дело с 10-19, чтобы менять окончание
    code:=10
  else
    code:=num_one;
  Translation_of_3:=Num_in_words;
end;
  
function Power(i:tten):string;//для больших разрядов,можно дополнить, но предварительно увеличив тип tten
begin
   case i of
  1:power:='миллион';
  2:power:='миллиард';
  3:power:='триллион';
  4:power:='квадриллион';
  5:power:='квинтиллион';
  6:power:='секстиллион';
  7:power:='септиллион';
  8:power:='октиллион';
  9:power:='нониллион';
  10:power:='дециллион';
  end;
end;

function MainTranslation(num:tbig;var lbl:boolean):string;//основная функция
var
  real_num,ercode:integer;//в эту переменную забиваем переведенные в число строки, ercode для ошибок val
  num_in_words,Main_Num_in_words:string;//переменные для хранения промежуточного результата
  code,i:tten;
begin
  lbl:=false;//пока ошибок нет
  val(copy(num,1,length(num)),real_num,ercode);
  if (ercode=0) and (real_num=0) then
    Main_Num_in_words:='Ноль'
  else
  begin
    val(copy(num,length(num)-2,3),real_num,ercode);//переводим последние 3 символа в строку 
    if ercode<>0 then
      lbl:=true;//если ввели не цифры, то ошибка
    Main_Num_in_words:=Translation_of_3(real_num,code);//переводим все что до тысячи
    delete(num,length(num)-2,3);//откидываем что перевели
    if length(num)>0 then//если число не меньше тысячи
    begin
      val(copy(num,length(num)-2,3),real_num,ercode);//берем колво тысяч 
      if ercode<>0 then//ловим ошибки
        lbl:=true; 
      begin
        Num_in_words:=Translation_of_3(real_num,code);//переводим тысячи
        case code of//меняем окончания в зависимости от единиц
          1: Num_in_words:=copy(Num_in_words,1,length(Num_in_words)-3)+'на тысяча ';
          2: Num_in_words:=copy(Num_in_words,1,length(Num_in_words)-2)+'е тысячи ';
          3,4:Num_in_words:=Num_in_words+'тысячи ';
        else Num_in_words:=Num_in_words+'тысяч ';
        end;
        if real_num<>0 then//дополняем строку только если не 0 тысяч
          Main_Num_in_words:=Num_in_words+Main_Num_in_words;
        delete(num,length(num)-2,3);
        i:=1;
        while length(num)>0 do//повторяем действия для миллиона,миллиарда и т.д.
        begin
          val(copy(num,length(num)-2,3),real_num,ercode);//берем разряд 
          if ercode<>0 then//ловим ошибки
            lbl:=true;
          Num_in_words:=Translation_of_3(real_num,code);//формируем слова
          case code of
            1: Num_in_words:=Num_in_words+power(i)+' ';
            2,3,4: Num_in_words:=Num_in_words+power(i)+'а ';
            else Num_in_words:=Num_in_words+power(i)+'ов ';
          end;
          if real_num<>0 then//если разряд не отсутствует
            Main_Num_in_words:=Num_in_words+Main_Num_in_words;
          i:=i+1;//увеличиваем разряд
          delete(num,length(num)-2,3);//убираем последние 3 цифры
        end;
      end;
    end;
  end;
  MainTranslation:=Main_num_in_words;//перевод успешен
end;

var
  num:tbig;//число
  Num_in_words,num_wihtout_changes:string;//как говорится
  lbl:boolean;

begin
  Input(num,num_wihtout_changes);//ввод
  Num_in_words:=MainTranslation(num,lbl);//перевод
  Output(Num_in_words,num_wihtout_changes,lbl);//вывод
end.