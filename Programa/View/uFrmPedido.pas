unit uFrmPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Datasnap.DBClient, FireDAC.Comp.Client,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Imaging.pngimage,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TfrmPedido = class(TForm)
    edtCodigoVenda: TDBEdit;
    Label1: TLabel;
    edtNumeroPedido: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtTipoOperacao: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    btnSalvar: TButton;
    btnNovo: TButton;
    Label8: TLabel;
    btnInsereProduto: TButton;
    btnRemoveItem: TButton;
    dsItens: TDataSource;
    gridItens: TDBGrid;
    dsClientes: TDataSource;
    dsPedido: TDataSource;
    DBLClientes: TDBLookupComboBox;
    queryClientes: TFDQuery;
    dtTempPedido: TClientDataSet;
    dtTempPedidoCOD_CLI: TIntegerField;
    edtDataEmi: TMaskEdit;
    edtReferencia: TEdit;
    dsTemporaria: TClientDataSet;
    dsTemporariaCOD_PROD: TIntegerField;
    dsTemporariaVALORUNITARIO: TFloatField;
    dsTemporariaQUANTIDADE: TFloatField;
    dsTemporariaTOTALITEM: TFloatField;
    edtTotalPedido: TMaskEdit;
    Image2: TImage;
    procedure btnInsereProdutoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnRemoveItemClick(Sender: TObject);
    procedure gridItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);

  private
    { Private declarations }
  public
    procedure CarregarClientes;
    function CalculaTotalPedido: Double;
  end;

var
  frmPedido: TfrmPedido;

implementation

{$R *.dfm}

uses uFrmPedidoProduto, uPedidoControl, uClienteControl, uItensPedidoControl;

procedure TfrmPedido.btnInsereProdutoClick(Sender: TObject);

begin
  Application.CreateForm(TPedidoProduto, PedidoProduto);
  try
    dsTemporaria.Append;
    PedidoProduto.ShowModal;

  finally
    PedidoProduto.Release;
  end;
end;

procedure TfrmPedido.btnNovoClick(Sender: TObject);
var
  VControlPedido: TPedidoControl;
begin
  // Libera campos
  edtReferencia.Enabled := True;
  DBLClientes.Enabled := True;
  btnInsereProduto.Enabled := True;
  btnRemoveItem.Enabled := True;
  gridItens.Enabled := True;

  VControlPedido := TPedidoControl.Create;

  edtCodigoVenda.Text := IntToStr(VControlPedido.PedidoModel.GetId);
  edtNumeroPedido.Text := IntToStr(VControlPedido.PedidoModel.GetId);

  edtDataEmi.Text := DateToStr(Date());
end;

procedure TfrmPedido.btnRemoveItemClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to gridItens.SelectedRows.Count - 1 do
  begin
    if Application.MessageBox('Deseja excluir o registro?', 'Aviso',
      MB_YESNO + MB_ICONQUESTION) = IDYES then

    begin
      gridItens.DataSource.DataSet.Delete;
      ShowMessage('Um item foi deletado');
      CalculaTotalPedido();
    end;

  end;

end;

procedure TfrmPedido.btnSalvarClick(Sender: TObject);
var
  VControlePedido: TPedidoControl;
  VControleItensPedido: TItensPedidoControl;
  VCodCliente: Integer;
begin
  VControlePedido := TPedidoControl.Create;

  VCodCliente := dsClientes.DataSet.FieldByName('COD_CLI').Value;
  try // SALVA OS DADOS DO PEDIDO

    try
      VControlePedido.PedidoModel.CodCliente := VCodCliente;
      VControlePedido.PedidoModel.Codigo := VControlePedido.PedidoModel.GetId;
      VControlePedido.PedidoModel.Referencia := edtReferencia.Text;
      VControlePedido.PedidoModel.NumeroPedido := StrToInt(edtCodigoVenda.Text);
      VControlePedido.PedidoModel.TipoOperacao := 2;
      VControlePedido.PedidoModel.TotalPedido :=
      StrToFloat(edtTotalPedido.Text);
    // VALIDA��O DOS CAMPOS
      if Trim(edtReferencia.Text) = '' then
      begin
        ShowMessage('Campo Referencia vazio');
      end

      else  // CASO N�O PARE EM NENHUMA VALIDA��O EXECUTA
      begin
        VControlePedido.SalvarPedido;

        try // SALVA OS DADOS DO ITEM

          dsTemporaria.First;
          while not dsTemporaria.eof do
          begin
            VControleItensPedido := TItensPedidoControl.Create;
            VControleItensPedido.ItensPedidoModel.CodPedido :=
              StrToInt(edtCodigoVenda.Text);
            VControleItensPedido.ItensPedidoModel.CodProduto :=
              gridItens.DataSource.DataSet.FieldByName('COD_PROD').Value;
            VControleItensPedido.ItensPedidoModel.Quantidade :=
              gridItens.DataSource.DataSet.FieldByName('QUANTIDADE').Value;
            VControleItensPedido.ItensPedidoModel.ValorUnitario :=
              gridItens.DataSource.DataSet.FieldByName('VALORUNITARIO').Value;
            VControleItensPedido.ItensPedidoModel.VlrTotalItem :=
              gridItens.DataSource.DataSet.FieldByName('TOTALITEM').Value;;

            VControleItensPedido.Salvar;
            dsTemporaria.Next;
          end;

        finally
          FreeAndNil(VControleItensPedido);

        end;
        frmPedido.Close;
      end;

    except

    end;

  finally

    VControlePedido.Free;
  end;

end;

procedure TfrmPedido.Button1Click(Sender: TObject);
var
  Total: Double;
begin
  Total := CalculaTotalPedido();
  ShowMessage(FloatToStr(Total));

end;

function TfrmPedido.CalculaTotalPedido: Double;
var
  Total: Double;
begin
  Total := 0.0;
  dsTemporaria.First;
  while (not dsTemporaria.eof) do
  begin
    Total := Total + dsTemporaria.FieldByName('TOTALITEM').AsCurrency;
    dsTemporaria.Next;
  end;
  Result := Total;
  edtTotalPedido.Text := FloatToStr(Total);

end;

procedure TfrmPedido.CarregarClientes;
var
  VControleClientes: TClienteControl;
begin
  VControleClientes := TClienteControl.Create;
  try
    queryClientes := VControleClientes.Obter;

    queryClientes.FetchAll;

    DBLClientes.ListSource.DataSet := queryClientes;
    DBLClientes.KeyField := 'COD_CLI';
    DBLClientes.ListField := 'NOME';

    DBLClientes.DataSource := dsPedido;
    DBLClientes.DataField := 'COD_CLI';

  finally
    FreeAndNil(VControleClientes);

  end;
end;

procedure TfrmPedido.FormShow(Sender: TObject);
begin
  CarregarClientes();
end;

procedure TfrmPedido.gridItensDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if State = [] then
  begin
    if dsItens.DataSet.RecNo mod 2 = 1 then
      gridItens.Canvas.Brush.Color := $C0C0C0
    else
      gridItens.Canvas.Brush.Color := clWhite;
  end;
  gridItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.
