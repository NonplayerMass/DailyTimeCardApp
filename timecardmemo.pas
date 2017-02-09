unit timecardmemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type

  TDate = class (TComponent)
  private
  protected
  public
    startDate: TDateTime;
    endDate: TDateTime;
    nowDate: TDateTime;
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
    AttendanceTimeSyncButton: TButton;
    LoadButton: TButton;
    TaikinTimeSyncButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure AttendanceButtonClick(Sender: TObject);
    procedure TaikinButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
    ftimeTime: TDate;
  end;

var
  Form1: TForm1;

implementation

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

procedure TForm1.FormCreate(Sender: TObject);
begin
  ftimeTime := TDate.Create(Self);
end;

procedure TForm1.SaveButtonClick(Sender: TObject);
var
  txtFile: TextFile;
  str, path: string;
begin
  str := FormatDateTime('hh:nn:ss', ftimeTime.startDate);
  str := str + ',' + FormatDateTime('hh:nn:ss', ftimeTime.endDate);
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
