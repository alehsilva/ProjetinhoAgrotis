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
    function Obter: TFDQuery;
    function Salvar: Boolean;
    function GetId(AAutoIncrementar: Integer): Integer;


    property Codigo: Integer read FCodigo write SetCodigo;
    property Nome: String read FNome write SetNome;
    property Acao: TAcao read FAcao write SetAcao;
  end;

implementation

{ TCliente }

uses uClienteDao;

function TClienteModel.Obter: TFDQuery;
var
  VClienteDao: TClienteDao;
begin
  VClienteDao := TClienteDao.Create;
  try
    Result := VClienteDao.Obter;
  finally
    VClienteDao.Free;
  end;
end;

function TClienteModel.Salvar: Boolean;
var
  VClienteDao: TClienteDao;
begin
  Result := False;
  VClienteDao := TClienteDao.Create;
  try
    case FAcao of
      uEnumerado.tacIncluir:
        Result := VClienteDao.Incluir(Self);
      uEnumerado.tacAlterar:
        Result := VClienteDao.Alterar(Self);
      uEnumerado.tacExcluir:
        Result := VClienteDao.Deletar(Self);
    end;
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

function TClienteModel.GetId(AAutoIncrementar: Integer): Integer;
var
  VClienteDao: TClienteDao;
begin
  VClienteDao := TClienteDao.Create;
  try
    Result := VClienteDao.GetId(AAutoIncrementar);
  finally
    VClienteDao.Free;
  end;
end;

end.
