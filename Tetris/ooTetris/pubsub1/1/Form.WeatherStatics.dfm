object WeatherStatics: TWeatherStatics
  Left = 420
  Top = 151
  Caption = 'Statistiques'
  ClientHeight = 349
  ClientWidth = 520
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 145
    Height = 349
    Align = alLeft
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 16
      Top = 24
      Width = 113
      Height = 177
      Caption = 'Afficher'
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 136
        Width = 89
        Height = 13
        Caption = '&Nombre de points :'
        FocusControl = UpDown1
      end
      object chbxTemp: TCheckBox
        Left = 16
        Top = 32
        Width = 87
        Height = 17
        Caption = '&Temp'#233'rature'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = chbxTempClick
      end
      object chbxHumidite: TCheckBox
        Left = 16
        Top = 72
        Width = 87
        Height = 17
        Caption = '&Humidit'#233
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = chbxHumiditeClick
      end
      object chbxPression: TCheckBox
        Left = 16
        Top = 112
        Width = 87
        Height = 17
        Caption = '&Pression'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = chbxPressionClick
      end
      object Edit1: TEdit
        Left = 16
        Top = 151
        Width = 31
        Height = 21
        ReadOnly = True
        TabOrder = 3
        Text = '20'
      end
      object UpDown1: TUpDown
        Left = 47
        Top = 151
        Width = 16
        Height = 21
        Associate = Edit1
        Max = 50
        Position = 20
        TabOrder = 4
      end
    end
  end
  object Panel2: TPanel
    Left = 145
    Top = 0
    Width = 375
    Height = 349
    Align = alClient
    TabOrder = 1
    object HumiditeChart: TChart
      Left = 1
      Top = 1
      Width = 373
      Height = 111
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Legend.Visible = False
      Title.Text.Strings = (
        'Humidit'#233' (en %)')
      Align = alTop
      TabOrder = 1
      ColorPaletteIndex = 13
      object LineSeries2: TLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Style = smsPercent
        Marks.Visible = False
        SeriesColor = clGreen
        Title = 'Humidit'#233
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = False
        XValues.DateTime = True
        XValues.Name = 'X '
        XValues.Order = loAscending
        YValues.Name = 'Y '
        YValues.Order = loNone
      end
    end
    object PressionChart: TChart
      Left = 1
      Top = 112
      Width = 373
      Height = 128
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Legend.Visible = False
      Title.Text.Strings = (
        'Pression (en millibars)')
      Align = alTop
      TabOrder = 0
      ColorPaletteIndex = 13
      object Series2: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Style = smsValue
        Marks.Visible = False
        SeriesColor = clRed
        Title = 'Pression'
        LinePen.Color = clRed
        XValues.DateTime = True
        XValues.Name = 'X '
        XValues.Order = loAscending
        YValues.Name = 'Y '
        YValues.Order = loNone
      end
    end
    object TempChart: TChart
      Left = 1
      Top = 240
      Width = 373
      Height = 128
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Legend.Visible = False
      Title.Text.Strings = (
        'Pression (en millibars)')
      Align = alTop
      TabOrder = 2
      ExplicitTop = 221
      ColorPaletteIndex = 13
      object FastLineSeries1: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Style = smsValue
        Marks.Visible = False
        SeriesColor = clRed
        Title = 'Pression'
        LinePen.Color = clRed
        XValues.DateTime = True
        XValues.Name = 'X '
        XValues.Order = loAscending
        YValues.Name = 'Y '
        YValues.Order = loNone
      end
    end
  end
end
