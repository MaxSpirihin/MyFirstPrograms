object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Hanoys Towers'
  ClientHeight = 303
  ClientWidth = 723
  Color = clSkyBlue
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object LDisks: TLabel
    Left = 604
    Top = 106
    Width = 71
    Height = 19
    Caption = 'Rings =   '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Lautor: TLabel
    Left = 547
    Top = 271
    Width = 168
    Height = 24
    Caption = 'By Spirikhin Maxim'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LSpeed: TLabel
    Left = 587
    Top = 213
    Width = 36
    Height = 16
    Caption = 'Speed'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Start: TButton
    Left = 600
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Start!!!'
    TabOrder = 0
    OnClick = StartClick
  end
  object Bpause: TButton
    Left = 600
    Top = 175
    Width = 75
    Height = 25
    Caption = 'Pause'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = BpauseClick
  end
  object TrackBar1: TTrackBar
    Left = 565
    Top = 125
    Width = 150
    Height = 20
    DoubleBuffered = False
    Max = 20
    Min = 1
    ParentDoubleBuffered = False
    ParentShowHint = False
    Position = 5
    ShowHint = False
    TabOrder = 2
    OnChange = TrackBar1Change
  end
  object TrackBar2: TTrackBar
    Left = 565
    Top = 240
    Width = 150
    Height = 25
    Max = 100
    Position = 40
    TabOrder = 3
    OnChange = TrackBar2Change
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 184
    Top = 104
  end
end
