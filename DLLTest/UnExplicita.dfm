object Form2: TForm2
  Left = 202
  Top = 171
  Caption = 'DLL Explicita'
  ClientHeight = 161
  ClientWidth = 232
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 73
    Height = 13
    Caption = 'Digite um texto:'
  end
  object Label2: TLabel
    Left = 16
    Top = 80
    Width = 40
    Height = 13
    Caption = 'N'#250'mero:'
  end
  object Label3: TLabel
    Left = 112
    Top = 80
    Width = 30
    Height = 13
    Caption = 'Texto:'
  end
  object edtTexto: TEdit
    Left = 16
    Top = 24
    Width = 201
    Height = 21
    TabOrder = 0
  end
  object btnMaiusculas: TButton
    Left = 16
    Top = 48
    Width = 89
    Height = 25
    Caption = 'Maiusculas'
    TabOrder = 1
    OnClick = btnMaiusculasClick
  end
  object btnMinusculas: TButton
    Left = 128
    Top = 48
    Width = 89
    Height = 25
    Caption = 'Minusculas'
    TabOrder = 2
    OnClick = btnMinusculasClick
  end
  object Edit1: TEdit
    Left = 112
    Top = 96
    Width = 105
    Height = 21
    TabOrder = 3
  end
  object SpinEdit1: TSpinEdit
    Left = 16
    Top = 96
    Width = 89
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 0
  end
  object Button1: TButton
    Left = 16
    Top = 123
    Width = 201
    Height = 25
    Caption = 'Converter'
    TabOrder = 5
    OnClick = Button1Click
  end
end
