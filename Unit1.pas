unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Objects,math;

type
  TNewEllipse = class
    public
    ellipse:TEllipse;
    radius,
    y,
    x,
    angle:Real;
    procedure Init (Sender:TComponent;r:Real;y_:Real);
    procedure draw_ellipse(x:real;y:real;r:real);
  end;
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure Timer1Timer(Sender: TObject);
  private
    started:Boolean;
    a:Array of TNewEllipse;
    dn,
    dx:real;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

const
  num = 100;

implementation

{$R *.fmx}

procedure TNewEllipse.draw_ellipse(x:Real; y: Real; r: Real);
 var dx:Word;
begin
  dx:=round(r);
  ellipse.position.x:=x-dx;
  ellipse.position.y:=y-(dx/3);
  ellipse.Width:=dx*2;
  ellipse.Height:=(dx*2)/3;
end;

procedure TNewEllipse.Init;
begin
 radius:=r;
 y:=y_;
 x:=Form1.clientwidth div 2;
 ellipse.Fill.Kind:=TBrushKind.bkNone;
 draw_ellipse(x,y,radius);
 Ellipse.Parent:=Form1;
end;


procedure TForm1.FormActivate(Sender: TObject);
var
  z: Integer;
begin
 if not Started then
  Begin
   SetLength(a,num+1);
   dn:=clientwidth / (num*2);
   dx:=1.5;
   for z := 0 to num do
     Begin
       a[z]:=TNewEllipse.Create;
       a[z].ellipse:=TEllipse.Create(Self);
       a[z].Init(Form1,z*dn,clientheight div 2);
     End;
  End;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
   var t1,t2,t3,ang:real;
begin
 t1:=a[0].x-x;
 t2:=a[0].y-y;
 if t1=0 then t3:=arctan(t2/(t1-0.00001)) else
  t3:=arctan(t2/t1);
 ang:=RadToDeg(t3)+90;
 a[0].angle:=ang;
 a[0].ellipse.RotationAngle:=a[0].angle*(-1);
 a[0].y := y;
 a[0].x := x;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
 var z:word;
begin
 a[0].draw_ellipse(a[0].x,a[0].y,a[0].radius);
 for z := 1 to num do
  Begin
   a[z].y := a[z].y+(a[z-1].y - a[z].y) / dx;
   a[z].x := a[z].x+(a[z-1].x - a[z].x) / dx;
   a[z].angle:= a[z].angle+(a[z-1].angle - a[z].angle) / 2;
   a[z].ellipse.RotationAngle:=a[z].angle;
   a[z].draw_ellipse(a[z].x,a[z].y,a[z].radius);
  End;
end;

end.
