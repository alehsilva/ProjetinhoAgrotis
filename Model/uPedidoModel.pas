unit uPedidoModel;

interface

uses
  DateUtils, uItensPedidoModel, System.SysUtils, System.Generics.Collections,
  uProdutoModel;

type
  TPedidoModel = class
  private
    FCodCliente: Integer;
    FCodigo: Integer;
    FDataEmi: TDate;
    FNumeroPedido: Integer;
    FReferencia: String;
    FTipoOperacao: Integer;

    procedure SetCodigo(const Value: Integer);
    procedure SetFCodCliente(const Value: Integer);
    procedure SetFDataEmi(const Value: TDate);
    procedure SetFNumeroPedido(const Value: Integer);
    procedure SetFTipoOperacao(const Value: Integer);
    procedure SetReferencia(const Value: String);
    procedure SetCodCliente(const Value: Integer);
    procedure SetDataEmi(const Value: TDate);
    procedure SetNumeroPedido(const Value: Integer);
    procedure SetTipoOperacao(const Value: Integer);


  public
    property Codigo : Integer read FCodigo write SetCodigo;
    property Referencia : String read FReferencia write SetReferencia;
    property NumeroPedido: Integer read FNumeroPedido write SetNumeroPedido;
    property DataEmi: TDate read FDataEmi write SetDataEmi;
    property CodCliente: Integer read FCodCliente write SetCodCliente;
    property TipoOperacao: Integer read FTipoOperacao write SetTipoOperacao;


    constructor Create;
    destructor Destroy ; override;




  end;

implementation


{ TPedidoModel }





constructor TPedidoModel.Create;
begin

end;

destructor TPedidoModel.Destroy;
begin

  inherited;
end;

procedure TPedidoModel.SetCodCliente(const Value: Integer);
begin
  FCodCliente := Value;
end;

procedure TPedidoModel.SetCodigo(const Value: Integer);
begin

end;

procedure TPedidoModel.SetDataEmi(const Value: TDate);
begin
  FDataEmi := Value;
end;

procedure TPedidoModel.SetFCodCliente(const Value: Integer);
begin

end;

procedure TPedidoModel.SetFDataEmi(const Value: TDate);
begin

end;

procedure TPedidoModel.SetFNumeroPedido(const Value: Integer);
begin

end;

procedure TPedidoModel.SetFTipoOperacao(const Value: Integer);
begin

end;

procedure TPedidoModel.SetNumeroPedido(const Value: Integer);
begin
  FNumeroPedido := Value;
end;

procedure TPedidoModel.SetReferencia(const Value: String);
begin

end;

procedure TPedidoModel.SetTipoOperacao(const Value: Integer);
begin
  FTipoOperacao := Value;
end;

end.
