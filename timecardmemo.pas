unit timecardmemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ExtCtrls;

type

  TDate = class (TComponent)
  private
  protected
  public
    startDate: TDateTime;
    endDate: TDateTime;
    nowDate: TDateTime;
    endTime1Date: TDateTime;
    startTime1Date: TDateTime;
    function GetStartTime: TDateTime;
    function GetEndTime: TDateTime;
  published
  end;


  TForm1 = class(TForm)
    AttendanceButton: TButton;
    TaikinButton: TButton;
    FileNameEdit: TEdit;
    SaveButton: TButton;
    AttendanceEdit: TEdit;
    TaikinEdit: TEdit;
    DiaryButton: TButton;
    KT1StartButton: TButton;
    KT1EndButton: TButton;
    KT1EndEdit: TEdit;
    KT1StartEdit: TEdit;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure AttendanceButtonClick(Sender: TObject);
    procedure TaikinButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure AttendanceSyncButtonClick(Sender: TObject);
    procedure KT1StartButtonClick(Sender: TObject);
    procedure KT1EndButtonClick(Sender: TObject);
    procedure DiaryButtonClick(Sender: TObject);
  private
    { Private 宣言 }

  public
    { Public 宣言 }
    ftimeTime: TDate;
  end;

var
  Form1: TForm1;

implementation


uses
  ShellAPI;

{$R *.dfm}




function TDate.GetStartTime: TDateTime;
begin
  Result := startDate;
end;
function TDate.GetEndTime: TDateTime;
begin
  Result := endDate;
end;




procedure TForm1.AttendanceButtonClick(Sender: TObject);
begin
  ftimeTime.startDate := System.SysUtils.GetTime;
  AttendanceEdit.Text := FormatDateTime('hh:nn:ss', ftimeTime.startDate);
end;


{

http://stackoverflow.com/questions/919244/converting-a-string-to-datetime

  DateTime myDate = DateTime.ParseExact("2009-05-08 14:40:52,531", "yyyy-MM-dd HH:mm:ss,fff",
                                       System.Globalization.CultureInfo.InvariantCulture)
}


procedure TForm1.AttendanceSyncButtonClick(Sender: TObject);
begin
  ftimeTime.startDate := System.SysUtils.GetTime;
  AttendanceEdit.Text := FormatDateTime('hh:nn:ss', ftimeTime.startDate);
end;
//
procedure TForm1.DiaryButtonClick(Sender: TObject);
var
  wFile: TFileStream;
  s : String;
  LCmdText   : String;
  LParams    : String;
  LhInstance : Cardinal;
begin
  wFile := TFileStream.Create('.\\mailtostr.txt', fmOpenRead);
  try
    Memo1.Lines.LoadFromStream(wFile);
    s := Memo1.Lines.Text;
  finally
    wFile.Free;
  end;
  LCmdText := 'mailto:'+s;
  LParams  := '';

  LhInstance := ShellExecute(Handle,
                             'open',
                             PChar(LCmdText),
                             PChar(LParams),
                             nil,
                             SW_SHOW);
//  if LhInstance <= 32 then begin
//    Windows.MessageBox(Handle, '起動に失敗しました', 'エラー', MB_ICONSTOP);

end;

//procedure TForm1.DiaryButtonClick(Sender: TObject);
//var
//  LCmdText   : String;
//  LParams    : String;
//  LhInstance : Cardinal;
//  LBodyText  : String;
//begin
//  LBodyText := 'メール新規作成 ? と %26 と改行文字には注意' + '%0D%0A'
//             + 'サンプルプログラムです';
//  LCmdText := 'mailto:'+LBodyText;
//  LParams  := '';
//
//  LhInstance := ShellExecute(Handle,
//                             'open',
//                             PChar(LCmdText),
//                             PChar(LParams),
//                             nil,
//                             SW_SHOW);
////  if LhInstance <= 32 then begin
////    Windows.MessageBox(Handle, '起動に失敗しました', 'エラー', MB_ICONSTOP);
//
//end;

//procedure TForm1.DiaryButtonClick(Sender: TObject);
//var
//  tf : TextFile;
//  s : String;
//  ssum : String;
//  LCmdText   : String;
//  LParams    : String;
//  LhInstance : Cardinal;
//begin
//  AssignFile(tf, '.\\mailtostr.txt');
//  Reset(tf);
//  ssum := '';
//  s := '';
//  while not Eof(tf) do
//  begin
//    Readln(tf, s);
//    ssum := ssum + sLineBreak + s;
//  end;
////  try
////    Memo1.Lines.LoadFromStream(wFile);
////    s := Memo1.Lines.Text;
////  finally
////    wFile.Free;
////  end;
//  LCmdText := 'mailto:'+ssum;
//  LParams  := '';
//
//  LhInstance := ShellExecute(Handle,
//                             'open',
//                             PChar(LCmdText),
//                             PChar(LParams),
//                             nil,
//                             SW_SHOW);
////  if LhInstance <= 32 then begin
////    Windows.MessageBox(Handle, '起動に失敗しました', 'エラー', MB_ICONSTOP);
//
//end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ftimeTime := TDate.Create(Self);
end;

procedure TForm1.KT1EndButtonClick(Sender: TObject);
begin
  ftimeTime.endTime1Date := System.SysUtils.GetTime;
  KT1EndEdit.Text := FormatDateTime('hh:nn:ss', ftimeTime.endTime1Date);
end;

procedure TForm1.KT1StartButtonClick(Sender: TObject);
begin
  ftimeTime.startTime1Date := System.SysUtils.GetTime;
  KT1StartEdit.Text := FormatDateTime('hh:nn:ss', ftimeTime.startTime1Date);
end;

procedure TForm1.SaveButtonClick(Sender: TObject);
var
  txtFile: TextFile;
  str, path: string;
begin
  str := FormatDateTime('hh:nn:ss', ftimeTime.startDate);
  str := str + ',' + FormatDateTime('hh:nn:ss', ftimeTime.endDate);
  str := str + ',' + FormatDateTime('hh:nn:ss', ftimeTime.startTime1Date);
  str := str + ',' + FormatDateTime('hh:nn:ss', ftimeTime.endTime1Date);
  path := FormatDateTime('yymmddhhnnss',Now);
  path := path+ '.csv';
//  path := '.\.txt';
  AssignFile(txtFile, path);
  if FileExists(path) then begin
    Append(txtFile);
  end else begin
    Rewrite(txtFile);
  end;
  Writeln(txtFile, str);
  CloseFile(txtFile);
end;

procedure TForm1.TaikinButtonClick(Sender: TObject);
begin
  ftimeTime.endDate := System.SysUtils.GetTime;
  TaikinEdit.Text := FormatDateTime('hh:nn:ss', ftimeTime.endDate);
end;

end.
