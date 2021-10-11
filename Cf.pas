unit Cf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, {обязательно} ShellApi, FileCtrl;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    DirectoryListBox1: TDirectoryListBox;
    DirectoryListBox2: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    DriveComboBox2: TDriveComboBox;
    Button2: TButton;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DirectoryListBox1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DirectoryListBox2MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
Label M;
var
 OpStruc:TSHFileOpStruct;
 frombuf,tobuf:array[0..128] of Char;
 Dir1,Dir2,s:string;
begin
 SelectDirectory('Просмотр каталога',Dir1,Dir2);
 if Dir2='' then goto M;
 FillChar(frombuf, Sizeof(frombuf), 0);
 FillChar(tobuf, Sizeof(tobuf), 0);
// s:='';
 StrPCopy(frombuf, 'd:\games');//что копируем
 StrPCopy(tobuf, Dir2);//куда копируем
 with OpStruc do
  begin
   Wnd:=Handle;
   wFunc:=FO_COPY;
   pFrom:=@frombuf;
   pTo:=@tobuf;
   fFlags:=FOF_NOCONFIRMATION or FOF_RENAMEONCOLLISION;
   fAnyOperationsAborted:=False;
   hNameMappings:=nil;
   lpszProgressTitle:=nil;
  end;
 ShFileOperation(OpStruc);
M:
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 DriveComboBox1.Drive:='c';
 DriveComboBox1.Drive:='d';
 DriveComboBox2.Drive:='c';
 DriveComboBox2.Drive:='d'; 
end;

procedure TForm1.Button2Click(Sender: TObject);
var
 OpStruc:TSHFileOpStruct;
 frombuf,tobuf:array[0..128] of Char;
begin
 if DirectoryListBox1.Directory='' then Exit;
 FillChar(frombuf, Sizeof(frombuf), 0);
 FillChar(tobuf, Sizeof(tobuf), 0);
 StrPCopy(frombuf, Label2.Caption);//что копируем
 StrPCopy(tobuf, Label3.Caption);//куда копируем
 with OpStruc do
  begin
   Wnd:=Handle;
   wFunc:=FO_COPY;
   pFrom:=@frombuf;
   pTo:=@tobuf;
   fFlags:=FOF_NOCONFIRMATION or FOF_RENAMEONCOLLISION;
   fAnyOperationsAborted:=False;
   hNameMappings:=nil;
   lpszProgressTitle:=nil;
  end;
 ShFileOperation(OpStruc);
 DirectoryListBox1.Update;
 DirectoryListBox2.Update;
end;

procedure TForm1.DirectoryListBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 Label2.Caption:=DirectoryListBox1.Directory;
 Label3.Caption:=DirectoryListBox2.Directory;
end;

procedure TForm1.DirectoryListBox2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 Label2.Caption:=DirectoryListBox1.Directory;
 Label3.Caption:=DirectoryListBox2.Directory;
end;

end.
