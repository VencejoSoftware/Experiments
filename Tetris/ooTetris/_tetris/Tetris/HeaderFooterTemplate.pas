unit HeaderFooterTemplate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, Tetris.Artifacts, System.Bindings.Expression,
  System.Bindings.Helper;

type
  THeaderFooterForm = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    HeaderLabel: TLabel;
    Left: TButton;
    Fall: TButton;
    Right: TButton;
    StyleBook1: TStyleBook;
    PlayGround: TImageControl;
    ImageControl1: TImageControl;
    rLeft: TButton;
    rRight: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Menu: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Message: TLabel;
    procedure LeftClick(Sender: TObject);
    procedure rLeftClick(Sender: TObject);
    procedure RightClick(Sender: TObject);
    procedure rRightClick(Sender: TObject);
    procedure FallClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure GameTerminate(sender: TObject);
  private
    FScreen: TScreen;
    b1, b2: TBindingExpression;
  public
    procedure ApplicactionIdle(Sender: TObject; var Done: boolean);
  end;

var
  HeaderFooterForm: THeaderFooterForm;

implementation

{$R *.fmx}

procedure THeaderFooterForm.ApplicactionIdle(Sender: TObject;
  var Done: boolean);
var
  b: TBitmap;
begin
  FScreen.Refresh;
  b := FScreen.Render;
  try
    PlayGround.Bitmap.Assign(b);
  finally
    b.Free;
  end;
end;

procedure THeaderFooterForm.Button1Click(Sender: TObject);
begin
  Menu.Visible := false;
  if assigned(FScreen) then
    FreeAndNil(FScreen);
  FScreen := TScreen.Create(PlayGround.Height, PlayGround.Width,
    PlayGround.Height / 20, PlayGround.Width / 15, 500);
  if assigned(b1) then
    FreeAndNil(b1);
  b1 := TBindings.CreateManagedBinding(
          [TBindings.CreateAssociationScope([Associate(FScreen, 'screen')])],
          'screen.Score',
          [TBindings.CreateAssociationScope([Associate(Label2, 'label')])],
          'label.Text',
          nil, nil);
  if assigned(b2) then
    FreeAndNil(b2);
  b2 := TBindings.CreateManagedBinding(
          [TBindings.CreateAssociationScope([Associate(FScreen, 'screen')])],
          'screen.NextPieceBmp',
          [TBindings.CreateAssociationScope([Associate(ImageControl1, 'image')])],
          'image.Bitmap',
          nil, nil);
  FScreen.OnGameOver := GameTerminate;
  Application.OnIdle := ApplicactionIdle;
end;

procedure THeaderFooterForm.Button2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure THeaderFooterForm.FallClick(Sender: TObject);
begin
  FScreen.Descend;
end;

procedure THeaderFooterForm.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  key := key + Ord(KeyChar);
  case key of
    vkRight: FScreen.MoveRight;
    vkLeft: FScreen.MoveLeft;
    vkUp: FScreen.RotateRight;
    vkDown: FScreen.RotateLeft;
    vkSpace: FScreen.Descend;
    vkMenu, vkEscape: begin
      &Message.Text := 'Game Finished';
      Application.OnIdle := nil;
      Menu.Visible := True;
    end;
  end;
end;

procedure THeaderFooterForm.GameTerminate(sender: TObject);
begin
  &Message.Text := 'Game Over';
  Menu.Visible := true;
end;

procedure THeaderFooterForm.LeftClick(Sender: TObject);
begin
  FScreen.MoveLeft;
end;

procedure THeaderFooterForm.RightClick(Sender: TObject);
begin
  FScreen.RotateRight;
end;

procedure THeaderFooterForm.rLeftClick(Sender: TObject);
begin
  FScreen.RotateLeft;
end;

procedure THeaderFooterForm.rRightClick(Sender: TObject);
begin
  FScreen.MoveRight;
end;

end.
