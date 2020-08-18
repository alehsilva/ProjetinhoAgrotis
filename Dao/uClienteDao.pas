unit uClienteDao;

interface

uses
  FireDAC.Comp.Client, uConexao, uClienteModel, System.SysUtils;

type
  TClienteDao = class
  private
    FConexao: TConexao;

  public
    constructor Create;

    function Obter: TFDQuery;
    function Incluir(AClienteModel: TClienteModel): Boolean;
    function Alterar(AClienteModel: TClienteModel): Boolean;
    function Deletar(AClienteModel: TClienteModel): Boolean;
    function GetId(AAutoIncrementar: Integer): Integer;

  end;

implementation

{ TClienteDao }

function TClienteDao.Alterar(AClienteModel: TClienteModel): Boolean;
var
  Vqry: TFDQuery;
begin
  Vqry := FConexao.CriarQuery();
  try
    Vqry.ExecSQL('UPDATE CLIENTES SET NOME = :NOME WHERE (COD_CLI = :Codigo)',
      [AClienteModel.Nome, AClienteModel.Codigo]);

    Result := True;
  finally
    Vqry.Free;
  end;
end;

constructor TClienteDao.Create;
begin
  FConexao := TConexao.Create;
end;

function TClienteDao.Deletar(AClienteModel: TClienteModel): Boolean;
var
  Vqry: TFDQuery;
begin
  Vqry := FConexao.CriarQuery();
  try
    Vqry.ExecSQL('DELETE FROM CLIENTES WHERE (COD_CLI = :Codigo)',[AClienteModel.Codigo]);

    Result := True;
  finally
    Vqry.Free;
  end;
end;

function TClienteDao.GetId(AAutoIncrementar: Integer): Integer;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.Open('select gen_id(gen_cliente_id, ' + IntToStr(AAutoIncrementar) + ' ) from rdb$database');
    try
      Result := VQry.Fields[0].AsInteger;
    finally
      VQry.Close;
    end;
  finally
    VQry.Free;
  end;
end;

function TClienteDao.Incluir(AClienteModel: TClienteModel): Boolean;
var
  Vqry: TFDQuery;
begin
  Vqry := FConexao.CriarQuery();
  try
    Vqry.ExecSQL('INSERT INTO CLIENTES (NOME) VALUES (:NOME)',
      [AClienteModel.Nome]);

    Result := True;
  finally
    Vqry.Free;
  end;

end;

function TClienteDao.Obter: TFDQuery;
var
  Vqry: TFDQuery;
begin
  Vqry := FConexao.CriarQuery();

  Vqry.Open('SELECT * FROM CLIENTES');

  Result := Vqry;
end;

end.
