unit uPedidoDao;

interface

uses
  FireDAC.Comp.Client, uConexao, System.SysUtils, uPedidoModel;

type
  TPedidoDao = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function GetId: integer;
    function SalvarPedido(APedidoModel: TPedidoModel): Boolean;

  end;

implementation

{ TPedidoDao }

constructor TPedidoDao.Create;
begin
  FConexao := TConexao.Create;
end;

function TPedidoDao.GetId: integer;
var
  ID: integer;
  Vqry: TFDQuery;
begin
  Vqry := FConexao.CriarQuery();
  try
    Vqry.Open('select max(COD_PED) from transacao');

    Result := Vqry.Fields[0].AsInteger + 1;
  finally
    Vqry.Free;
  end;
end;

function TPedidoDao.SalvarPedido(APedidoModel: TPedidoModel): Boolean;
var
  Vqry: TFDQuery;
begin
  Vqry := FConexao.CriarQuery();
  try
    Vqry.ExecSQL
      ('insert into TRANSACAO (COD_PED , REFERENCIA , NUMPEDIDO, COD_CLI, TIPOOPERACAO, TOTALPEDIDO) values (:Codigo, :Referencia, :NumeroPedido, :CodCliente, :TipoOperacao, :TotalPedido)',
      [APedidoModel.Codigo, APedidoModel.Referencia, APedidoModel.NumeroPedido,
      APedidoModel.CodCliente, APedidoModel.TipoOperacao,
      APedidoModel.TotalPedido]);
    Result := True;
  finally
    Vqry.Free;
  end;
end;

end.
