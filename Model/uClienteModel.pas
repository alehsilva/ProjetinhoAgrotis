unit uClienteModel;

interface

uses uEnumerado, FireDAC.Comp.Client;
type
  TClienteModel = class
  private
    FAcao: TAcao;
    FCodigo: Integer;
    FNome: String;

    procedure SetAcao(const Value: TAcao);
    procedure SetCodigo(const Value: Integer);
    procedure SetNome(const Value: String);

    public
      function Obter : TFDQuery;

      property Codigo: Integer read FCodigo write SetCodigo;
      property Nome: String read FNome write SetNome;
      property Acao: TAcao read FAcao write SetAcao;
  end;
implementation

{ TCliente }

uses uClienteDao;

function TClienteModel.Obter: TFDQuery;
var
  VClienteDao : TClienteDao;
begin
   VClienteDao := TClienteDao.Create;
  try
    Result := VClienteDao.Obter;
  finally
    VClienteDao.Free;
  end;
end;

procedure TClienteModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TClienteModel.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TClienteModel.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.