unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Grids;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    Greckie: TRadioButton;
    Arabskie: TRadioButton;
    Rzymskie: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1DblClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


const RZYM_L = 7;
const GRECKIE_L = 9;
arabskie1: Array[0..RZYM_L-1] of Integer = (1000, 500, 100, 50, 10, 5, 1);
rzymski: Array[0..RZYM_L-1] of String = ('M', 'D', 'C', 'L', 'X', 'V', 'I');
arabskie21: Array[0..GRECKIE_L-1] of Integer = (900, 800, 700, 600, 500, 400, 300, 200, 100);
arabskie22: Array[0..GRECKIE_L-1] of Integer = (90, 80, 70, 60, 50, 40, 30, 20, 10);
arabskie23: Array[0..GRECKIE_L-1] of Integer = (9, 8, 7, 6, 5, 4, 3, 2, 1);
grecki1: Array[0..GRECKIE_L-1] of String = ('Ϡ', 'ω', 'ψ', 'χ', 'φ', 'υ', 'τ', 'σ', 'ρ');
grecki2: Array[0..GRECKIE_L-1] of String = ('Ϟ', 'π', 'ο', 'ξ', 'ν', 'μ', 'λ', 'κ', 'ι');
grecki3: Array[0..GRECKIE_L-1] of String = ('θ', 'η', 'ζ', 'Ϝ', 'ε', 'δ', 'γ', 'β', 'α');

function arab2rzym(numer1: integer): string;
var i: integer;
begin
i:=0;
result:='';

    while ((numer1 > 0) and (i < RZYM_L)) do
    begin
      if (numer1 >= arabskie1[i]) then
      begin
        numer1 := numer1 - arabskie1[i];
        result := result + rzymski[i];
      end

      else if ((i mod 2 = 0) and
      (i < RZYM_L-2) and                                         // dla 9xx
      (numer1 >= arabskie1[i] - arabskie1[i+2]) and
      (arabskie1[i+2] <> arabskie1[i] - arabskie1[i+2])) then
      begin
        numer1 := numer1 - (arabskie1[i] - arabskie1[i+2]);
        result:= result + rzymski[i+2] + rzymski[i];
        i := i+1;
      end

      else if ((i mod 2 = 1) and          //dla 4xx
      (i < RZYM_L-1) and
      (numer1 >= arabskie1[i] - arabskie1[i+1]) and
      (arabskie1[i+1] <> arabskie1[i] - arabskie1[i+1])) then
      begin
        numer1 := numer1 - (arabskie1[i] - arabskie1[i+1]);
        result := result + rzymski[i+1] + rzymski[i];
        i := i+1;
      end

      else
      begin
        i:=i+1;
      end;
    end;
  end;
function rzym2arab(numer1:string; dl:integer):integer;

var i, j:integer;
begin

    result:=0;
    i:=0;
    j:=1;

  while ((j<=dl) and (i<RZYM_L)) do
     begin
       if (numer1[j] = rzymski[i]) then
       begin
        result:= result + arabskie1[i];
          j:=j+1;
       end
       else if ((i mod 2 =0) and (i<RZYM_L-2) and (j<=dl-1) and (numer1[j] = rzymski[i+2]) and (numer1[j+1]=rzymski[i])) then
       begin
        result := result + (arabskie1[i] - arabskie1[i+2]);
        j:=j+2;
        i:=i+1;
       end
       else if ((i mod 2 = 1) and (i<RZYM_L-1) and (j<=dl-1) and (numer1[j] = rzymski[i+1]) and (numer1[j+1] = rzymski[i])) then
       begin
        result:=result + (arabskie1[i] - arabskie1[i+1]);
        j:=j+2;
        i:=i+1;
       end
       else
       begin
         i:=i+1;
       end;

       if (i=RZYM_L) then begin
        result:=-1;
        end;
    end;

end;
function arab2grek(numer1:integer):string;
var i:integer;
begin
  i:=0;

  while((numer1>0)and(i<GRECKIE_L)) do
       begin
            if (numer1>=arabskie21[i])then
            begin
                 result:=result+grecki1[i];
                 numer1:=numer1 mod 100;
                 break;
            end;
                i:=i+1;
       end;
           i:=0;
       while((numer1>0)and(i<GRECKIE_L)) do
       begin
            if (numer1>=arabskie22[i])then
            begin
                 result:=result+grecki2[i];
                 numer1:=numer1 mod 10;
                 break;
            end;
                 i:=i+1;
       end;
        i:=0;
        while((numer1>0)and(i<GRECKIE_L)) do
        begin
             if (numer1>=arabskie23[i])then
             begin
                  result:=result+grecki3[i];
                  break;
             end;
             i:=i+1;
        end;
end;

procedure TForm1.Edit1Change(Sender: TObject);

begin

end;

procedure TForm1.Edit1DblClick(Sender: TObject);
begin
  Edit1.Text:='';
end;

procedure TForm1.Button1Click(Sender: TObject);
var i, j, numer1, numer2, numer3:integer;
begin
  i:= 0;

  if ((Edit1.Text <= '/') or (Edit1.Text >= ':')) then begin
     Edit1.Text := 'Podaj liczbe Arabska!';
     exit;
  end else begin
    numer1:=StrToInt(Edit1.Text);
  end;

  Edit1.Text:= '';

  if Rzymskie.Checked = True then
  begin
    if ((numer1 > 3899) and (CheckBox1.Checked = true)) then
    begin
        numer2:=numer1 div 100;
        numer1:=numer1 mod 100;

        Edit1.Text:=Edit1.text + arab2rzym(numer2);
        Edit1.Text:='|'+Edit1.text+'|';

    end else if (numer1<=0) then begin
      exit;
    end else if ((numer1 > 3899) and (CheckBox1.Checked = false)) then
    begin
      Edit1.text:='Zbyt duża liczba';
      exit;
    end;

    i:=0;

    Edit1.Text:=Edit1.Text + arab2rzym(numer1);
  end

  else if Greckie.Checked = True then
  begin

    if (numer1 >= 10000000) then begin
      Edit1.Text:='Przekroczono zakres';
      exit;
    end;

    if ((numer1>=10000) and (numer1<1000000)) then
    begin
      if (CheckBox1.Checked = True) then
      begin

        numer3:=numer1 div 10000;
        numer1:=numer1 mod 10000;

        Edit1.Text:=arab2grek(numer3);
        Edit1.Text:=Edit1.Text+'M ';

      end;
    end;

    if (numer1>=1000) and (numer1<10000) then
    begin
      if (CheckBox1.Checked = True) then
      begin


           numer2:=numer1 div 1000;
           numer1:=numer1 mod 1000;


         Edit1.Text:=arab2grek(numer2);
         Edit1.Text:=Edit1.Text+'ι ';

      end;
    end;


    if (numer1<1000) then
       begin

            Edit1.Text:=arab2grek(numer1);
       end;


    end;

  end;

procedure TForm1.Button2Click(Sender: TObject);
var i, j, dl, wynik : integer;
var numer1:string;
begin
  wynik:=0;
  i:=0;
  j:=1;
  dl:= length(Edit1.Text);
  numer1:=Edit1.Text;





  if Rzymskie.checked = true then begin
    exit;
  end;

  Edit1.Text:='';

  if Arabskie.Checked = true then begin

   Edit1.Text:=IntToStr(rzym2arab(numer1, dl));

   if Greckie.Checked = true then begin
    Edit1.Text:=IntToStr(rzym2arab(numer1, dl));

   end;
end;

end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

end.

