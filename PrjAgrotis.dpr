program PrjAgrotis;

uses
  Vcl.Forms,
  FPrincipalView in 'View\FPrincipalView.pas' {Form1},
  uConexao in 'Dao\uConexao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.