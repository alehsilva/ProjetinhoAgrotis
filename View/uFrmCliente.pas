unit uFrmCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uClienteControl, uClienteModel,
  uEnumerado;

type
  TfrmCadastroCliente = class(TForm)
    edtCodigo: TEdit;
    edtNome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    mmTableClientes: TFDMemTable;
    DBGrid1: TDBGrid;
    dsClientes: TDataSource;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    procedure CarregarClientes;
  public
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

{$R *.dfm}
{ TfrmCadastroCliente }

procedure TfrmCadastroCliente.btnAlterarClick(Sender: TObject);
var
  VControleCliente: TClienteControl;
begin
  VControleCliente := TClienteControl.Create;
  try
    VControleCliente.ClienteModel.Acao := uEnumerado.tacAlterar;
    VControleCliente.ClienteModel.Codigo := StrToInt(edtCodigo.Text);
    VControleCliente.ClienteModel.Nome := edtNome.Text;

    if VControleCliente.Salvar then
      ShowMessage('Alterado com sucesso!');

    self.CarregarClientes();
  finally
    VControleCliente.Free;
  end;
end;

procedure TfrmCadastroCliente.btnExcluirClick(Sender: TObject);
var
  VControleCliente: TClienteControl;
begin
  VControleCliente := TClienteControl.Create;
  try
    VControleCliente.ClienteModel.Acao := uEnumerado.tacExcluir;
    VControleCliente.ClienteModel.Codigo := StrToInt(edtCodigo.Text);
    VControleCliente.ClienteModel.Nome := edtNome.Text;

    if VControleCliente.Salvar then
      ShowMessage('Exclu�do com sucesso!');

    self.CarregarClientes();
  finally
    VControleCliente.Free;
  end;
end;

procedure TfrmCadastroCliente.btnIncluirClick(Sender: TObject);
var
  VControleCliente: TClienteControl;
begin
  VControleCliente := TClienteControl.Create;
  try
    VControleCliente.ClienteModel.Acao := uEnumerado.tacIncluir;
    VControleCliente.ClienteModel.Nome := edtNome.Text;

    if VControleCliente.Salvar then
      ShowMessage('Incluido com sucesso!');

    self.CarregarClientes();
  finally
    VControleCliente.Free;
  end;
end;

procedure TfrmCadastroCliente.CarregarClientes;
var
  VControleCliente: TClienteControl;
  VQry: TFDQuery;
begin
  VControleCliente := TClienteControl.Create;
  try
    VQry := VControleCliente.Obter;
    try
      VQry.FetchAll;
      mmTableClientes.Close;
      mmTableClientes.Data := VQry.Data;
    finally
      VQry.Close;
      FreeAndNil(VQry);

    end;
  finally
    FreeAndNil(VControleCliente);
  end;
end;

procedure TfrmCadastroCliente.FormShow(Sender: TObject);
begin
  self.CarregarClientes();
end;

end.
