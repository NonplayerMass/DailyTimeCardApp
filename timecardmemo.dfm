object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #20986#36864#21220#35352#37682
  ClientHeight = 110
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object AttendanceButton: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = #20986#21220
    TabOrder = 0
    OnClick = AttendanceButtonClick
  end
  object TaikinButton: TButton
    Left = 8
    Top = 39
    Width = 75
    Height = 25
    Caption = #36864#21220
    TabOrder = 1
    OnClick = TaikinButtonClick
  end
  object FileNameEdit: TEdit
    Left = 89
    Top = 70
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'date201702021240.csv'
  end
  object SaveButton: TButton
    Left = 8
    Top = 70
    Width = 75
    Height = 25
    Caption = 'save'
    TabOrder = 3
    OnClick = SaveButtonClick
  end
  object AttendanceEdit: TEdit
    Left = 89
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '08:30'
  end
  object TaikinEdit: TEdit
    Left = 89
    Top = 39
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '22:00'
  end
  object AttendanceTimeSyncButton: TButton
    Left = 216
    Top = 8
    Width = 75
    Height = 25
    Caption = 'TimeSync'
    TabOrder = 6
  end
  object LoadButton: TButton
    Left = 216
    Top = 68
    Width = 75
    Height = 25
    Caption = 'load'
    TabOrder = 7
  end
  object TaikinTimeSyncButton: TButton
    Left = 216
    Top = 37
    Width = 75
    Height = 25
    Caption = 'TimeSync'
    TabOrder = 8
  end
end
