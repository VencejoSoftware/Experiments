object MainForm: TMainForm
  Left = 8
  Top = 22
  Caption = 'Weather demo'
  ClientHeight = 122
  ClientWidth = 330
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
  object lblInfo: TLabel
    Left = 16
    Top = 24
    Width = 113
    Height = 13
    Caption = 'Informations courantes :'
  end
  object Label1: TLabel
    Left = 16
    Top = 48
    Width = 101
    Height = 13
    Caption = 'Temp'#233'rature (en '#176'C) :'
  end
  object Label2: TLabel
    Left = 16
    Top = 72
    Width = 79
    Height = 13
    Caption = 'Humidit'#233' (en %) :'
  end
  object Label3: TLabel
    Left = 16
    Top = 96
    Width = 106
    Height = 13
    Caption = 'Pression (en millibars) :'
  end
  object lblTemperature: TLabel
    Left = 136
    Top = 48
    Width = 6
    Height = 13
    Caption = '?'
  end
  object lblHumidity: TLabel
    Left = 136
    Top = 72
    Width = 6
    Height = 13
    Caption = '?'
  end
  object lblPression: TLabel
    Left = 136
    Top = 96
    Width = 6
    Height = 13
    Caption = '?'
  end
  object btnStats: TButton
    Left = 240
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Statistiques'
    TabOrder = 0
    OnClick = btnStatsClick
  end
  object btnListing: TButton
    Left = 240
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Listing'
    TabOrder = 1
    OnClick = btnListingClick
  end
end
