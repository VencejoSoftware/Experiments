object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 239
  ClientWidth = 513
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object JvDateEdit1: TJvDateEdit
    Left = 40
    Top = 32
    Width = 105
    Height = 21
    Hint = 'Control hint'
    ParentShowHint = False
    ShowHint = True
    ShowNullDate = False
    TabOrder = 0
    TextHint = 'Text hint'
  end
  object Button1: TButton
    Left = 151
    Top = 31
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 1
    OnClick = Button1Click
  end
end
