unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, CheckLst, ExtCtrls, Menus;

type
  EWaLoadError = class(Exception)
  end;

  TWormsWeapon = record
   Ammo: 0..10;
   Power: 0..4;
   Delay: 0..9;
   Crates: 0..5;
  end;

  TWormsScheme = record
   TypeText: array [0..3] of Char;// $00-$04
   Unknown: array [0..$26-4] of Byte;//$05-$26
   SpecWeap: Boolean;//$27
   SuperWeap: Boolean;//$28
   Weapons: array [0..44] of TWormsWeapon;//$029-$221
  end;

  TFileFormat = class(TPersistent)
   private
   protected
    procedure GetData(Value: Stream);
   public
   published
  end;

  TForm1 = class(TForm)
    OD: TOpenDialog;
    Panel1: TPanel;
    Button1: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    AmmoTrack: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    PowerTrack: TTrackBar;
    TabSheet2: TTabSheet;
    CratesTrack: TTrackBar;
    Label3: TLabel;
    DelayTrack: TTrackBar;
    Label4: TLabel;
    ListBox1: TListBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    SD: TSaveDialog;
    Button5: TButton;
    MainMenu1: TMainMenu;
    Filer1: TMenuItem;
    Hjlp1: TMenuItem;
    Ny1: TMenuItem;
    bn1: TMenuItem;
    Gem1: TMenuItem;
    Gemsom1: TMenuItem;
    N1: TMenuItem;
    Info1: TMenuItem;
    N2: TMenuItem;
    Afslut1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure WeapTrackChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    Scheme: TWormsScheme;
  public
    { Public declarations }
  end;

const
 WormsSchemeSize = SizeOf(TWormsScheme);

function LoadWaScheme(Scheme: TStream): TWormsScheme; overload;
function LoadWaScheme(Scheme: TStream; var Error: Boolean): TWormsScheme;
 overload;
function LoadWaSchemeFromFile(Path: String): TWormsScheme; overload;
function LoadWaSchemeFromFile(Path: String; var Error: Boolean): TWormsScheme;
 overload;
function LoadWaSchemeFromRes(Instance: Longint; Resource: String;
 DataType: String): TWormsScheme; overload;
function LoadWaSchemeFromRes(Instance: Longint; Resource: String;
 DataType: String; var Error: Boolean): TWormsScheme; overload;

function IsWaSchemeFile(Path: string): Boolean;
function IsWaScheme(Scheme: TStream): Boolean;

var
  Form1: TForm1;
  SchemePath: String;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
 if OD.Execute then begin
  if IsWaSchemeFile(OD.FileName) then
   Scheme := LoadWaSchemeFromFile(OD.FileName)
  else
   raise EWaLoadError.CreateFmt('Ugyldigt filformat i fil: %s', [OD.FileName]);
  ListBox1.ItemIndex := 0;
  ListBox1Click(ListBox1);
  SchemePath := OD.FileName;
  OD.InitialDir := ExtractFilePath(OD.FileName);
 end;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
var
 WeapIndex: Integer;
begin
 with TListBox(Sender) do
  case ItemIndex of
   0..30: WeapIndex := ItemIndex;
   32..39: WeapIndex := ItemIndex-1;
   41..46: WeapIndex := ItemIndex-2
   else
    WeapIndex := -1;
  end;
  if WeapIndex = -1 then begin
   AmmoTrack.Position := 0;
   PowerTrack.Position := 0;
   DelayTrack.Position := 0;
   CratesTrack.Position := 0;
  end
  else begin
   AmmoTrack.Position := Scheme.Weapons[WeapIndex].Ammo;
   PowerTrack.Position := Scheme.Weapons[WeapIndex].Power;
   DelayTrack.Position := Scheme.Weapons[WeapIndex].Delay;
   CratesTrack.Position := Scheme.Weapons[WeapIndex].Crates;
  end;
end;

procedure TForm1.WeapTrackChange(Sender: TObject);
var
 WeapIndex: Integer;
begin
 with ListBox1 do
  case ItemIndex of
   0..30: WeapIndex := ItemIndex;
   32..39: WeapIndex := ItemIndex-1;
   41..46: WeapIndex := ItemIndex-2
   else
    Exit
  end;
  case TComponent(Sender).Name[1] of
    'A': Scheme.Weapons[WeapIndex].Ammo := AmmoTrack.Position;
    'P': Scheme.Weapons[WeapIndex].Power := PowerTrack.Position;
    'D': Scheme.Weapons[WeapIndex].Delay := DelayTrack.Position;
    'C': Scheme.Weapons[WeapIndex].Crates := CratesTrack.Position;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 if (Scheme.TypeText = 'SCHM') and FileExists(SchemePath) then
  with TFileStream.Create(OD.FileName, fmCreate) do begin
   WriteBuffer(Scheme, WormsSchemeSize);
   Free;
  end
 else begin
  Scheme.TypeText := 'SCHM';
  Button3Click(nil);
 end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 If SD.Execute then
  with TFileStream.Create(OD.FileName, fmCreate) do begin
   WriteBuffer(Scheme, WormsSchemeSize);
   Free;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 if ParamCount = 0 then begin
  Scheme := LoadWaSchemeFromRes(HInstance, 'INTERMEDIATE', 'WaSchm');
 end else
  Scheme := LoadWaSchemeFromFile(ParamStr(1));
end;

function LoadWaSchemeFromFile(Path: String): TWormsScheme; overload;
var
 Error: Boolean;
begin
 Result := LoadWaSchemeFromFile(Path, Error);
 if Error then
  raise EWaLoadError.CreateFmt('Ugyldigt filformat i fil: %s.', [Path]);
end;

function LoadWaSchemeFromFile(Path: String; var Error: Boolean): TWormsScheme; overload;
var
 TmpScheme: TFileStream;
begin
 TmpScheme := TFileStream.Create(Path, fmOpenRead);
 Result := LoadWaScheme(TmpScheme, Error);
 TmpScheme.Free;
end;

function LoadWaScheme(Scheme: TStream): TWormsScheme; overload;
var
 Error: Boolean;
begin
 Result := LoadWaScheme(Scheme, Error);
 if Error then
  raise EWaLoadError.Create('Ugyldigt format i fil.');
end;

function LoadWaScheme(Scheme: TStream; var Error: Boolean): TWormsScheme;
 overload;
begin 
 Error := not IsWaScheme(Scheme);
 Scheme.Position := 0;
 if not Error then
  with Scheme do begin
   ReadBuffer(Result, WormsSchemeSize);
   Free;
  end;
end;

function LoadWaSchemeFromRes(Instance: Longint; Resource: String;
 DataType: String): TWormsScheme; overload;
var
 Error: Boolean;
begin
 Result := LoadWaSchemeFromRes(Instance, Resource, DataType, Error);
 if Error then
  raise EWaLoadError.CreateFmt('Ugyldigt format i resource: %s.', [Resource]);
end;

function LoadWaSchemeFromRes(Instance: Longint; Resource: String;
 DataType: String; var Error: Boolean): TWormsScheme; overload;
var
 TmpScheme: TResourceStream;
begin
 TmpScheme := TResourceStream.Create(Instance, Resource, PChar(DataType));
 Result := LoadWaScheme(TmpScheme, Error);
// TmpScheme.Free;
end;

function IsWaScheme(Scheme: TStream): Boolean;
var
 TmpStr : Array [1..4] of Char;
begin
 Scheme.Read(TmpStr, 4);
 if (TmpStr = 'SCHM') and ((Scheme.Size = 221) or
  ((Scheme.ClassType = TResourceStream) and (Scheme.Size = 222))) then
  Result := True
 else
  Result := False;
end;

function IsWaSchemeFile(Path: string): Boolean;
var
 TmpStream: TFileStream;
begin
 TmpStream := TFileStream.Create(Path, fmOpenRead);
 Result := IsWaScheme(TmpStream);
 TmpStream.Free;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
 OD.InitialDir := ExtractFilePath(ParamStr(0))+'Samples';
 ListBox1.ItemIndex := 0;
 ListBox1Click(ListBox1);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 Scheme := LoadWaSchemeFromRes(HInstance, 'Empty', 'WaSchm');
 ListBox1.ItemIndex := 0;
 ListBox1Click(ListBox1);
end;

end.
