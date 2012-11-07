object Form1: TForm1
  Left = 192
  Top = 107
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 329
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 288
    Width = 536
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Button1: TButton
      Left = 368
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Å&bn...'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 286
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Gem'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 203
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Ge&m som...'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 120
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Ny'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 451
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Luk'
      TabOrder = 4
      OnClick = Button5Click
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 536
    Height = 288
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Våben'
      object Label1: TLabel
        Left = 237
        Top = 7
        Width = 29
        Height = 13
        Caption = 'Ammo'
      end
      object Label2: TLabel
        Left = 385
        Top = 7
        Width = 30
        Height = 13
        Caption = 'Styrke'
      end
      object Label3: TLabel
        Left = 385
        Top = 69
        Width = 32
        Height = 13
        Caption = 'Kasser'
      end
      object Label4: TLabel
        Left = 237
        Top = 69
        Width = 42
        Height = 13
        Caption = 'Vente tid'
      end
      object AmmoTrack: TTrackBar
        Left = 231
        Top = 25
        Width = 147
        Height = 45
        Orientation = trHorizontal
        Frequency = 1
        Position = 0
        SelEnd = 0
        SelStart = 0
        TabOrder = 0
        TickMarks = tmBottomRight
        TickStyle = tsAuto
        OnChange = WeapTrackChange
      end
      object PowerTrack: TTrackBar
        Left = 379
        Top = 25
        Width = 147
        Height = 45
        Max = 4
        Orientation = trHorizontal
        Frequency = 1
        Position = 0
        SelEnd = 0
        SelStart = 0
        TabOrder = 1
        TickMarks = tmBottomRight
        TickStyle = tsAuto
        OnChange = WeapTrackChange
      end
      object CratesTrack: TTrackBar
        Left = 379
        Top = 87
        Width = 147
        Height = 45
        Max = 5
        Orientation = trHorizontal
        Frequency = 1
        Position = 0
        SelEnd = 0
        SelStart = 0
        TabOrder = 2
        TickMarks = tmBottomRight
        TickStyle = tsAuto
        OnChange = WeapTrackChange
      end
      object DelayTrack: TTrackBar
        Left = 231
        Top = 87
        Width = 147
        Height = 45
        Max = 9
        Orientation = trHorizontal
        Frequency = 1
        Position = 0
        SelEnd = 0
        SelStart = 0
        TabOrder = 3
        TickMarks = tmBottomRight
        TickStyle = tsAuto
        OnChange = WeapTrackChange
      end
      object ListBox1: TListBox
        Left = 0
        Top = 0
        Width = 222
        Height = 260
        Align = alLeft
        ItemHeight = 13
        Items.Strings = (
          'Bazooka'
          'Homing Misile'
          'Mortar'
          'Hand Granade'
          'Cluster Bomb'
          'Skunk Bomb'
          'Patrol Bomb'
          'Banana Bomb'
          'Hand Gun'
          'Shotgun'
          'Usi'
          'Minigun'
          'Longbow'
          'Air Strike'
          'Napalm Strike'
          'Land Mine'
          'Fire Punch'
          'Dragon Ball'
          'Kemikaze'
          'Prod'
          'Axe'
          'Blow Torch'
          'Pneumatic Drill'
          'Girder'
          'Ninja Rope'
          'Dynamite'
          'Sheep'
          'Baseball Bat'
          'Parachute'
          'Bungee'
          'Teleport'
          '(Special Våben)'
          'Flame Thrower'
          'Homing Pigeon'
          'Mad Cow'
          'Holy Hand Grenade'
          'Old Woman'
          'Sheep Launcher'
          'Super Sheep'
          'Mole Bomb'
          '(Utilities)'
          'Jet Pack'
          'Low Gravity'
          'Laser Sight'
          'Fast Walk'
          '???'
          '???')
        TabOrder = 4
        OnClick = ListBox1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Instillinger'
      ImageIndex = 1
    end
  end
  object OD: TOpenDialog
    DefaultExt = '*.wsc'
    Filter = 'Worms Skemaer (*.wsc)|*.wsc|Alle Filer (*.*)|*.*'
    Left = 502
    Top = 2
  end
  object SD: TSaveDialog
    DefaultExt = '*.wsc'
    Filter = 'Worms Skemaer (*.wsc)|*.wsc|Alle Filer (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofExtensionDifferent, ofPathMustExist, ofEnableSizing]
    Left = 474
    Top = 2
  end
  object MainMenu1: TMainMenu
    Left = 445
    Top = 2
    object Filer1: TMenuItem
      Caption = '&Filer'
      object Ny1: TMenuItem
        Caption = '&Ny'
      end
      object bn1: TMenuItem
        Caption = 'Å&bn...'
        OnClick = Button1Click
      end
      object Gem1: TMenuItem
        Caption = '&Gem'
        OnClick = Button2Click
      end
      object Gemsom1: TMenuItem
        Caption = 'Ge&m som...'
        OnClick = Button3Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Info1: TMenuItem
        Caption = 'Info...'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Afslut1: TMenuItem
        Caption = '&Afslut'
        OnClick = Button5Click
      end
    end
    object Hjlp1: TMenuItem
      Caption = '&Hjælp'
    end
  end
end
