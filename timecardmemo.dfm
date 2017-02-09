object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #20986#36864#21220#35352#37682
  ClientHeight = 180
  ClientWidth = 301
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
    Top = 142
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'date201702021240.csv'
  end
  object SaveButton: TButton
    Left = 8
    Top = 142
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
  object DiaryButton: TButton
    Left = 216
    Top = 140
    Width = 75
    Height = 25
    Caption = #26085#22577
    TabOrder = 6
    OnClick = DiaryButtonClick
  end
  object KT1StartButton: TButton
    Left = 8
    Top = 72
    Width = 75
    Height = 25
    Caption = #20241#25001#38283#22987
    TabOrder = 7
    OnClick = KT1StartButtonClick
  end
  object KT1EndButton: TButton
    Left = 8
    Top = 103
    Width = 75
    Height = 25
    Caption = #20241#25001#32066#20102
    TabOrder = 8
    OnClick = KT1EndButtonClick
  end
  object KT1EndEdit: TEdit
    Left = 89
    Top = 103
    Width = 121
    Height = 21
    TabOrder = 9
    Text = '22:00'
  end
  object KT1StartEdit: TEdit
    Left = 89
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 10
    Text = '08:30'
  end
  object Memo1: TMemo
    Left = 216
    Top = 8
    Width = 75
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 11
    Visible = False
  end
end
