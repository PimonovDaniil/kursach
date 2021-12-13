unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Grids, TAGraph, TASeries, TARadialSeries, TAMultiSeries;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  kol,kol2:integer;
  res: array of integer; //массив того, какие строи не добавлять
  sym: array of boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var i,j,p,k:integer; flag:boolean;
begin
  //showmessage(form1.StringGrid1.Cells[1,1]);
  try
   //for i:=1 to StringGrid1.RowCount-1 do begin  //типо проверка на числа
   //  for p:=1 to StringGrid1.ColCount-1 do begin
   //     strtoint(form1.StringGrid1.Cells[p,i]);
   //  end;
   //end;
  for i:=1 to StringGrid1.RowCount-1 do begin
    for j:=1 to StringGrid1.RowCount-1 do begin
      if i <> j then begin
         //сравниваем 2 элемента
         flag:= false;
         for p:=1 to StringGrid1.ColCount-1 do begin
            if sym[p-1] = true then begin
               if form1.StringGrid1.Cells[p,j] > form1.StringGrid1.Cells[p,i] then begin
                  flag:= true;
                  break;
               end;
            end else begin
               if form1.StringGrid1.Cells[p,j] < form1.StringGrid1.Cells[p,i] then begin
                  flag:= true;
                  break;
               end;
            end;
         end;
         if flag = false then begin
            setlength(res,length(res)+1);
            res[length(res)-1]:=j;
         end;
      end;
    end;
  end;
 { for i:=0 to length(res)-1 do begin
    showmessage(inttostr(res[i]));
  end; }
  k:=1;
   for i:=1 to StringGrid1.RowCount-1 do begin
     flag:= true;
     for j:=0 to length(res)-1 do begin
          if i = res[j] then begin
             flag := false;
             break;
          end;
     end;
     if flag = true then begin
        form1.StringGrid2.RowCount:=form1.StringGrid2.RowCount+1;
        for p:=1 to StringGrid1.ColCount-1 do begin
           form1.StringGrid2.Cells[p,k]:=form1.StringGrid1.Cells[p,i];
        end;
        k:=k+1;
     end;
   end;

   except
     showmessage('Введите верные данные в таблицу');
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  form1.StringGrid1.RowCount:=form1.StringGrid1.RowCount+1;
  form1.StringGrid1.Cells[0,kol2]:= 'x'+inttostr(kol2);
  kol2:=kol2+1;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if trim(form1.Edit1.Text) <> '' then begin
      setlength(sym, kol);
      if form1.RadioButton1.Checked = true then begin
         sym[kol-1]:=true;
      end else begin
         sym[kol-1]:=false;
      end;
      form1.StringGrid1.ColCount:=form1.StringGrid1.ColCount+1;
      form1.StringGrid2.ColCount:=form1.StringGrid2.ColCount+1;
      form1.StringGrid1.Cells[kol,0]:= trim(form1.Edit1.Text);
      form1.StringGrid2.Cells[kol,0]:= trim(form1.Edit1.Text);
      form1.Edit1.Text:='';
      kol:=kol+1;
  end else begin
      showmessage('Введите название критерия');
  end;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  form1.StringGrid1.ColCount:=1;
  form1.StringGrid1.RowCount:=1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  kol:=1;
  kol2:=1;
end;

end.
