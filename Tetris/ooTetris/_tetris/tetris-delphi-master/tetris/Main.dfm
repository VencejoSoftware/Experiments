object Form1: TForm1
  Left = 762
  Top = 67
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'TETRIS-FLY'
  ClientHeight = 273
  ClientWidth = 338
  Color = clNavy
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000000000000000000000444444444444111111111111111111004CC
    CC44CCCC4199991199991199991004CCCC44CCCC4199991199991199991004CC
    CC44CCCC4199991199991199991004CCCC44CCCC419999119999119999100444
    44444444411111111111111111100444444555555555555111111222222004CC
    CC45DDDD55DDDD51999912AAAA2004CCCC45DDDD55DDDD51999912AAAA2004CC
    CC45DDDD55DDDD51999912AAAA2004CCCC45DDDD55DDDD51999912AAAA200444
    44455555555555511111122222200444444666666555555555555222222004CC
    CC46EEEE65DDDD55DDDD52AAAA2004CCCC46EEEE65DDDD55DDDD52AAAA2004CC
    CC46EEEE65DDDD55DDDD52AAAA2004CCCC46EEEE65DDDD55DDDD52AAAA200444
    44466666655555555555522222200666666666666333333333333222222006EE
    EE66EEEE63BBBB33BBBB32AAAA2006EEEE66EEEE63BBBB33BBBB32AAAA2006EE
    EE66EEEE63BBBB33BBBB32AAAA2006EEEE66EEEE63BBBB33BBBB32AAAA200666
    66666666633333333333322222200666666007700333333333333222222006EE
    EE60788703BBBB33BBBB32AAAA2006EEEE67800873BBBB33BBBB32AAAA2006EE
    EE67800873BBBB33BBBB32AAAA2006EEEE60788703BBBB33BBBB32AAAA200666
    6660077003333333333332222220000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 224
    Top = 96
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1054#1095#1082#1080': 0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Arbat-Bold'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 208
    Top = 120
    Width = 89
    Height = 17
    AutoSize = False
    Caption = #1057#1082#1086#1088#1086#1089#1090#1100': 1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Arbat-Bold'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 200
    Top = 216
    Width = 42
    Height = 13
    Caption = 'Label3'
    Color = clNavy
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Arbat-Bold'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label4: TLabel
    Left = 216
    Top = 144
    Width = 32
    Height = 13
    Caption = #1051#1077#1075#1082#1086
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Arbat-Bold'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 264
    Top = 152
    Width = 55
    Height = 13
    Caption = #1051#1091#1095#1096#1080#1081': 0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Arbat-Bold'
    Font.Style = []
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 16
    Top = 16
    Width = 153
    Height = 217
    BevelInner = bvLowered
    TabOrder = 0
    object Image1: TImage
      Left = 13
      Top = 9
      Width = 124
      Height = 192
    end
  end
  object Panel2: TPanel
    Left = 200
    Top = 0
    Width = 89
    Height = 89
    BevelInner = bvLowered
    TabOrder = 1
    object Image2: TImage
      Left = 8
      Top = 8
      Width = 65
      Height = 73
    end
  end
  object MainMenu1: TMainMenu
    Left = 200
    Top = 176
    object mnuGame: TMenuItem
      Caption = '&'#1048#1075#1088#1072
      object mnuNew: TMenuItem
        Caption = '&'#1053#1086#1074#1072#1103
        ShortCut = 113
        OnClick = mnuNewClick
      end
      object mnuRecords: TMenuItem
        Caption = '&'#1056#1077#1082#1086#1088#1076#1099
        GroupIndex = 3
        ShortCut = 16466
        OnClick = mnuRecordsClick
      end
      object mnuS1: TMenuItem
        Caption = '-'
        GroupIndex = 3
      end
      object mnuExit: TMenuItem
        Caption = #1042#1099'&'#1093#1086#1076
        GroupIndex = 3
        ShortCut = 16465
        OnClick = mnuExitClick
      end
    end
    object mnuLev: TMenuItem
      Caption = '&'#1057#1083#1086#1078#1085#1086#1089#1090#1100
      object mnuLevA: TMenuItem
        Caption = '&'#1051#1077#1075#1082#1086
        OnClick = mnuLevAClick
      end
      object mnuLevB: TMenuItem
        Caption = '&'#1057#1083#1086#1078#1085#1086
        OnClick = mnuLevBClick
      end
      object mnuLevC: TMenuItem
        Caption = '&'#1054#1095#1077#1085#1100' '#1089#1083#1086#1078#1085#1086
        OnClick = mnuLevCClick
      end
    end
    object mnuHelp: TMenuItem
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      ShortCut = 123
      object mnuHelpFile: TMenuItem
        Caption = '&'#1057#1087#1088#1072#1074#1082#1072
        ShortCut = 123
        OnClick = mnuHelpFileClick
      end
      object mnuS2: TMenuItem
        Caption = '-'
      end
      object mnuAbout: TMenuItem
        Caption = '&'#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        OnClick = mnuAboutClick
      end
    end
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 240
    Top = 176
  end
end
