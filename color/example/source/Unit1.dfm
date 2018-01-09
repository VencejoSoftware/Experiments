object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 268
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 8
    Top = 8
    Width = 89
    Height = 81
    Brush.Color = clGreen
  end
  object Shape2: TShape
    Left = 103
    Top = 8
    Width = 89
    Height = 81
    Brush.Color = clGreen
  end
  object Shape3: TShape
    Left = 198
    Top = 8
    Width = 89
    Height = 81
    Brush.Color = clGreen
  end
  object Shape4: TShape
    Left = 293
    Top = 8
    Width = 89
    Height = 81
    Brush.Color = clGreen
  end
  object Shape5: TShape
    Left = 388
    Top = 8
    Width = 89
    Height = 81
    Brush.Color = 884978
  end
  object Button1: TButton
    Left = 8
    Top = 104
    Width = 89
    Height = 25
    Caption = 'Invert'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 103
    Top = 104
    Width = 89
    Height = 25
    Caption = 'Greyscale'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 198
    Top = 104
    Width = 89
    Height = 25
    Caption = 'Light'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 293
    Top = 104
    Width = 89
    Height = 25
    Caption = 'Dark'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 388
    Top = 104
    Width = 89
    Height = 25
    Caption = 'Contrast'
    TabOrder = 4
    OnClick = Button5Click
  end
end
