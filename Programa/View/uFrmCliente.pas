unit uFrmCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uClienteControl, uClienteModel,
  uEnumerado, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TfrmCadastroCliente = class(TForm)
    mmTableClientes: TFDMemTable;
    DBGrid1: TDBGrid;
    dsClientes: TDataSource;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    Image1: TImage;
    Image2: TImage;
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
// Alterar Cliente
var
  VControleCliente: TClienteControl;
  VNome: String;
  VCodigo: String;
begin
  VControleCliente := TClienteControl.Create;
  try

    VCodigo := InputBox('Alterar',
      'Digite o c�digo do Cliente que deseja alterar', EmptyStr);
    VNome := InputBox('Alterar', 'Digite o novo nome do Cliente', EmptyStr);
    try
      VControleCliente.ClienteModel.Acao := uEnumerado.tacAlterar;
      VControleCliente.ClienteModel.Nome := VNome;
      VControleCliente.ClienteModel.Codigo := StrToInt(VCodigo);
    except // Erro de convers�o
      on E: EConvertError do
      begin
        ShowMessage
          ('Um dos valores digitados n�o corresponde com o formato do campo!');
      end;

    end;

    if VNome = '' then
    begin
      ShowMessage('O nome do Cliente n�o pode estar em branco!');
    end

    else
    begin

      if VControleCliente.Salvar then
      begin
        self.CarregarClientes();
      end

      else if not VControleCliente.Salvar then
      begin
        ShowMessage('N�o encontramos o Cliente');
      end;

    end;

  finally
    VControleCliente.Free;
  end;
end;

procedure TfrmCadastroCliente.btnExcluirClick(Sender: TObject);
// Excluir Cliente
var
  VControleCliente: TClienteControl;
  VCodigo: String;
  VNome: String;
begin
  VControleCliente := TClienteControl.Create;
  VCodigo := InputBox('Excluir',
    'Digite o c�digo do Cliente que deseja excluir', EmptyStr);

  if VCodigo.Trim <> EmptyStr then
  begin
    if (Application.MessageBox('Deseja excluir o registro?', 'Confirma��o',
      MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION) = mrYes) then
    begin
      try
        VControleCliente.ClienteModel.Acao := uEnumerado.tacExcluir;
        VControleCliente.ClienteModel.Nome := VNome;
        try
          VControleCliente.ClienteModel.Codigo := StrToInt(VCodigo);
        except
          on E: EConvertError do
          begin
            ShowMessage(VCodigo + ' <- N�o � um c�digo v�lido!');

          end;

        end;
        try
          if VControleCliente.Salvar then
          begin
            self.CarregarClientes();
          end;
        except
          on E: Exception do
              ShowMessage('N�o � poss�vel excluir um cliente que est� v�nculado a um pedido!');

        end;

        finally
          VControleCliente.Free;
        end;
      end;
    end;
  end;

  procedure TfrmCadastroCliente.btnIncluirClick(Sender: TObject);
  // Incluir Cliente
  var
    VControleCliente: TClienteControl;
    VNome: String;
  begin
    VControleCliente := TClienteControl.Create;
    VNome := InputBox('Incluir', 'Digite o nome do cliente', EmptyStr);
    try
      VControleCliente.ClienteModel.Acao := uEnumerado.tacIncluir;
      VControleCliente.ClienteModel.Nome := VNome;

      if VNome = '' then
      begin
        ShowMessage('O nome do cliente n�o pode estar em branco!');
      end

      else
      begin
        if VControleCliente.Salvar then
          ShowMessage('Inclu�do com sucesso!');

        self.CarregarClientes();
      end;

    finally
      VControleCliente.Free;
    end;
  end;

  procedure TfrmCadastroCliente.CarregarClientes; // Carregar Cliente
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
