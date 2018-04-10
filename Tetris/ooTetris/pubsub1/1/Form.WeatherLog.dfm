object WeatherLogForm: TWeatherLogForm
  Left = 16
  Top = 203
  Caption = 'Log'
  ClientHeight = 332
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 265
    Height = 332
    Align = alLeft
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      '')
    ParentFont = False
    TabOrder = 0
  end
  object btnReinit: TButton
    Left = 280
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Reinit'
    TabOrder = 1
    OnClick = btnReinitClick
  end
  object btnClose: TButton
    Left = 280
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Close'
    Default = True
    TabOrder = 2
    OnClick = btnCloseClick
  end
end
