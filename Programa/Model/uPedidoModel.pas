unit uPedidoModel;

interface

uses
  DateUtils, uItensPedidoModel, System.SysUtils, System.Generics.Collections;

type
  TPedidoModel = class
  private
    FCodCliente: Integer;
    FCod_Ped: Integer;
    FNumeroPedido: Integer;
    FReferencia: String;
    FTipoOperacao: Integer;
    FTotalPedido: Double;

    procedure SetCodCliente(const Value: Integer);
    procedure SetCod_Ped(const Value: Integer);
    procedure SetNumeroPedido(const Value: Integer);
    procedure SetReferencia(const Value: String);
    procedure SetTipoOperacao(const Value: IntegeR);
    procedure SetTotalPedido(const Value: Double);



  public
    property Codigo : Integer read FCod_Ped write SetCod_Ped;
    property Referencia : String read FReferencia write SetReferencia;
    property NumeroPedido: Integer read FNumeroPedido write SetNumeroPedido;
    property CodCliente: Integer read FCodCliente write FCodCliente;
    property TipoOperacao: IntegeR read FTipoOperacao write SetTipoOperacao;
    property TotalPedido : Double read FTotalPedido write SetTotalPedido;

    function GetId : Integer;
    function SalvarPedido : Boolean;

  end;

implementation


{ TPedidoModel }

uses uPedidoDao;


function TPedidoModel.GetId: Integer;
var
VPedidoDao : TPedidoDao;
begin
   VPedidoDao := TPedidoDao.Create;
   try
     Result := VPedidoDao.GetId();
   finally
     VPedidoDao.Free;
   end;
end;


function TPedidoModel.SalvarPedido: Boolean;
var VPedido : TPedidoDao;
begin
    VPedido := TPedidoDao.Create;
    try
        Result :=  VPedido.SalvarPedido(Self);
    finally
    VPedido.Free;
    end;
end;

procedure TPedidoModel.SetCodCliente(const Value: Integer);
begin
  FCodCliente := Value;
end;

procedure TPedidoModel.SetCod_Ped(const Value: Integer);
begin
  FCod_Ped := Value;
end;


procedure TPedidoModel.SetNumeroPedido(const Value: Integer);
begin
  FNumeroPedido := Value;
end;

procedure TPedidoModel.SetReferencia(const Value: String);
begin
  FReferencia := Value;
end;

procedure TPedidoModel.SetTipoOperacao(const Value: IntegeR);
begin
  FTipoOperacao := Value;
end;

procedure TPedidoModel.SetTotalPedido(const Value: Double);
begin
  FTotalPedido := Value;
end;

end.
