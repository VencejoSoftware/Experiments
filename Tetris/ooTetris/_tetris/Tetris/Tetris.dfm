object FrmMain: TFrmMain
  Left = 915
  Top = 375
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #53580#53944#47532#49828'v1.0'
  ClientHeight = 337
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 171
    Top = 0
    Width = 113
    Height = 318
    Align = alRight
    TabOrder = 0
    object LbScore: TLabel
      Left = 75
      Top = 285
      Width = 13
      Height = 25
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LbLevel: TLabel
      Left = 74
      Top = 261
      Width = 13
      Height = 25
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 7
      Top = 288
      Width = 66
      Height = 19
      Caption = 'SCORE : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 264
      Width = 60
      Height = 19
      Caption = 'LEVEL : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 111
      Height = 70
      Align = alTop
      TabOrder = 0
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 171
    Height = 318
    Align = alClient
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 318
    Width = 284
    Height = 19
    Panels = <
      item
        Alignment = taRightJustify
        Text = 'ljh3326@naver.com'
        Width = 50
      end>
    SimpleText = 'Copyright'
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 248
    Top = 8
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    Left = 240
    Top = 56
    object N1: TMenuItem
      Caption = #47700#45684
      object N3: TMenuItem
        Caption = #49884#51089
        OnClick = N3Click
      end
      object N4: TMenuItem
        Caption = #51333#47308
        OnClick = N4Click
      end
    end
    object N2: TMenuItem
      Caption = #51221#48372
      object N5: TMenuItem
        Caption = #51221#48372
        OnClick = N5Click
      end
    end
  end
end
