unit uProdutoDao;

interface

uses
  FireDAC.Comp.Client, uConexao, System.SysUtils, uProdutoModel;

type
  TProdutoDao = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function Obter: TFDQuery;
    function Incluir(AProdutoModel: TProdutoModel): Boolean;
    function Alterar(AProdutoModel: TProdutoModel): Boolean;
    function Deletar(AProdutoModel: TProdutoModel): Boolean;
    function GetId(AAutoIncrementar: Integer): Integer;
  end;

implementation

{ TProdutoDao }

function TProdutoDao.Alterar(AProdutoModel: TProdutoModel): Boolean;
var
  Vqry: TFDQuery;
begin
  Vqry := FConexao.CriarQuery();
  try
    Vqry.ExecSQL
      ('update PRODUTO set DESC_PROD = :Nome where (COD_PROD = :Codigo)', [AProdutoModel.Nome, AProdutoModel.Codigo]);
  finally
    Vqry.Free;
  end;
end;

constructor TProdutoDao.Create;
begin
  FConexao := TConexao.Create;
end;

function TProdutoDao.Deletar(AProdutoModel: TProdutoModel): Boolean;
var
  Vqry: TFDQuery;
begin
  Vqry := FConexao.CriarQuery();
  try
    Vqry.ExecSQL('delete from PRODUTO where (COD_PROD = :Codigo)', [AProdutoModel.Codigo]);
    Result := True;
  finally
    Vqry.Free;
  end;
end;

function TProdutoDao.GetId(AAutoIncrementar: Integer): Integer;
var
  Vqry: TFDQuery;
begin
  Vqry := FConexao.CriarQuery();
  try
    Vqry.Open('select gen_id(COD_PROD, ' + IntToStr(AAutoIncrementar) +
      ' ) from rdb$database');
    try
      Result := Vqry.Fields[0].AsInteger;
    finally
      Vqry.Close;
    end;
  finally
    Vqry.Free;
  end;
end;

function TProdutoDao.Incluir(AProdutoModel: TProdutoModel): Boolean;
var
  Vqry: TFDQuery;
begin
  Vqry := FConexao.CriarQuery();
  try
    Vqry.ExecSQL('insert into PRODUTO (DESC_PROD) values (:Nome)', [AProdutoModel.Nome]);
    Result := True;
  finally
    Vqry.Free;
  end;
end;

function TProdutoDao.Obter: TFDQuery;
var
  Vqry: TFDQuery;
begin
  Vqry := FConexao.CriarQuery();
  Vqry.Open('select * from PRODUTO');

  Result := Vqry;
end;

end.
