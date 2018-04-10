object Form1: TForm1
  Left = 192
  Top = 109
  Caption = 'Form1'
  ClientHeight = 546
  ClientWidth = 1025
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 121
    Height = 321
  end
  object Image1: TImage
    Left = 152
    Top = 48
    Width = 41
    Height = 41
  end
  object Edit1: TLabel
    Left = 152
    Top = 96
    Width = 3
    Height = 13
  end
  object BitBtn1: TBitBtn
    Left = 152
    Top = 0
    Width = 65
    Height = 33
    Caption = 'Jouer!!'
    TabOrder = 0
    TabStop = False
    OnClick = BitBtn1Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
  end
end
