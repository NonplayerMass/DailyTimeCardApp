unit timecardmemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ExtCtrls, System.DateUtils,
  Vcl.AppEvnts;

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
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure AttendanceButtonClick(Sender: TObject);
    procedure TaikinButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure AttendanceSyncButtonClick(Sender: TObject);
    procedure KT1StartButtonClick(Sender: TObject);
    procedure KT1EndButtonClick(Sender: TObject);
    procedure DiaryButtonClick(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
  private
    { Private êÈåæ }

  public
    { Public êÈåæ }
    ftimeTime: TDate;
  end;

var
  Form1: TForm1;

implementation


uses
  ShellAPI;

{$R *.dfm}


function GetTimeSa(startTime: TDateTime; endTime: TDateTime): string;
var
  sahour: Integer;
  samin: Integer;
  sabyou: Integer;
  min: Integer;
  sec: Integer;
begin
  sahour := HoursBetween(startTime, endTime);
  samin := MinutesBetween(startTime, endTime);
  sabyou := SecondsBetween(startTime, endTime);
  min := samin mod 60;
  sec := sabyou mod 60;
  Result := Format('%.2d', [sahour]) + ':' +Format('%.2d', [min])+':'+Format('%.2d', [sec]);
end;



function GetTimeSaKyukei(startTime: TDateTime; endTime: TDateTime;
kstartTime: TDateTime; kendTime: TDateTime
): string;
var
  samin: Integer;
  ksamin: Integer;
  hour: Integer;
  min: Integer;
//  sec: Integer;
begin
  samin := MinutesBetween(startTime, endTime);
  ksamin := MinutesBetween(kstartTime, kendTime);
  samin := samin - ksamin;
  hour := samin div 60;
  min := samin mod 60;
//  sec := 0;
  Result := Format('%.2d', [hour]) + ':' +Format('%.2d', [min]);  //+':'+Format('%.2d', [sec]);
end;



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
  sr : String;
  LCmdText   : String;
  LParams    : String;
  LhInstance : Cardinal;
begin
  wFile := TFileStream.Create('.\\mailtostr.txt', fmOpenRead);
  try
    Memo1.Lines.LoadFromStream(wFile);
    s := Memo1.Lines.Text;
    sr := StringReplace(s, '[STARTTIME]', AttendanceEdit.Text, [rfReplaceAll]);
    sr := StringReplace(sr, '[ENDTIME]', TaikinEdit.Text, [rfReplaceAll]);
    sr := StringReplace(sr, '[DATE]', FormatDateTime('yyyy/mm/dd',Now), [rfReplaceAll]);
    sr := StringReplace(sr, '[SAGYOTIME]', GetTimeSaKyukei(ftimeTime.startDate, ftimeTime.endDate, ftimeTime.startTime1Date, ftimeTime.endTime1Date), [rfReplaceAll]);
  finally
    wFile.Free;
  end;
  LCmdText := 'mailto:'+sr;
  LParams  := '';

  LhInstance := ShellExecute(Handle,
                             'open',
                             PChar(LCmdText),
                             PChar(LParams),
                             nil,
                             SW_SHOW);
  if LhInstance <= 32 then
  begin
    //TODO
//    Windows.MessageBox(Handle, 'ãNìÆÇ…é∏îsÇµÇ‹ÇµÇΩ', 'ÉGÉâÅ[', MB_ICONSTOP);
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  MyIcon : TIcon;
begin
  ftimeTime := TDate.Create(Self);
  ftimeTime.startDate := System.SysUtils.GetTime;
  ftimeTime.endDate := System.SysUtils.GetTime;
  ftimeTime.startTime1Date := System.SysUtils.GetTime;
  ftimeTime.endTime1Date := System.DateUtils.IncHour(Now, 1);
  TaikinEdit.Text := FormatDateTime('hh:nn:ss', ftimeTime.endDate);
  AttendanceEdit.Text := FormatDateTime('hh:nn:ss', ftimeTime.startDate);
  KT1StartEdit.Text := FormatDateTime('hh:nn:ss', ftimeTime.startTime1Date);
  KT1EndEdit.Text := FormatDateTime('hh:nn:ss', ftimeTime.endTime1Date);

//
//  ShowWindow(Application.Handle,SW_HIDE);
//  Application.ShowMainForm := False;
  { Load the tray icons. }
  TrayIcon1.Icons := TImageList.Create(Self);
////  MyIcon := TIcon.Create;
////  MyIcon.LoadFromFile('D:\work\prj_timecardapp\DailyTimeCardApp-master\DailyTimeCardApp\icosyukin.ico');
//  TrayIcon1.Icon.Assign(MyIcon);
//  TrayIcon1.Icons.AddIcon(MyIcon);

//  MyIcon.LoadFromFile('icons/earth2.ico');
//  TrayIcon1.Icons.AddIcon(MyIcon);
//  MyIcon.LoadFromFile('icons/earth3.ico');
//  TrayIcon1.Icons.AddIcon(MyIcon);
//  MyIcon.LoadFromFile('icons/earth4.ico');
//  TrayIcon1.Icons.AddIcon(MyIcon);

  { Set up a hint message and the animation interval. }
//  TrayIcon1.Hint := 'Hello World!';
//  TrayIcon1.AnimateInterval := 200;
//
//  { Set up a hint balloon. }
//  TrayIcon1.BalloonTitle := 'Restoring the window.';
//  TrayIcon1.BalloonHint :=
//    'Double click the system tray icon to restore the window.';
//  TrayIcon1.BalloonFlags := bfInfo;


    Hide();
  WindowState := wsMinimized;


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

  ftimeTime.endTime1Date := System.DateUtils.IncHour(Now, 1);
  KT1EndEdit.Text := FormatDateTime('hh:nn:ss', ftimeTime.endTime1Date);
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


procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin

  { Hide the tray icon and show the window,
  setting its state property to wsNormal. }
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
  { Hide the window and set its state variable to wsMinimized. }
  Hide();
  WindowState := wsMinimized;

  { Show the animated tray icon and also a hint balloon. }
  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;
  TrayIcon1.ShowBalloonHint;
end;

end.
