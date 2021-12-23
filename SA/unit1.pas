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
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  kol,kol2:integer;
  res: array of integer; //массив того, какие строи не добавлять
  sym: array of boolean;
  granA:array of double;
  granB:array of double;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var i,j,p,k:integer; flag,flag2:boolean;
begin
  try
    flag2:=true;
    for i:=1 to StringGrid1.RowCount-1 do
       for p:=1 to StringGrid1.ColCount-1 do
          if ((granA[i-1]<>-1) and (granB[i-1]<>-1)) then
             if not ((strtofloat(form1.StringGrid1.Cells[p,i])>=granA[i-1]) and (strtofloat(form1.StringGrid1.Cells[p,i])<=granB[i-1])) then
                flag2:=false;
    if flag2 = true then begin
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
       form1.Button1.Enabled:=false;
    end else
       showmessage('Введите верные данные в таблицу');
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
var a,b:double;
begin
  try
    if trim(form1.Edit1.Text) <> '' then begin
        if ((form1.Edit2.Text <> '') and (form1.Edit3.Text = '')) or
        ((form1.Edit2.Text = '') and (form1.Edit3.Text <> ''))then begin
            showmessage('Неверно введены границы');
        end else begin
            if  (form1.Edit2.Text <> '') and (form1.Edit3.Text <> '') then begin
                a:= strtofloat(form1.Edit2.Text);
                b:= strtofloat(form1.Edit3.Text);
                setlength(granA, kol); granA[kol-1]:=a;
                setlength(granB, kol); granB[kol-1]:=b;
            end else begin
                setlength(granA, kol); granA[kol-1]:=-1;
                setlength(granB, kol); granB[kol-1]:=-1;
            end;
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
        end;
    end else begin
        showmessage('Введите название критерия');
    end;
  except
     showmessage('Неверно введены данные');
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  kol:=1;
  kol2:=1;
end;

end.

