unit uProdutoControl;

interface
uses
  uProdutoModel, System.SysUtils, FireDAC.Comp.Client;

  type
    TProdutoControl = class
      private
       FProdutoModel : TProdutoModel;

      public
       constructor Create;
       destructor Destroy; override;

       function Salvar: Boolean;
       function Obter: TFDQuery;
       function GetId(AAutoIncrementar: Integer): Integer;

       property ProdutoModel: TProdutoModel read FProdutoModel write FProdutoModel;
    end;

implementation

{ TProdutoControl }

constructor TProdutoControl.Create;
begin
  FProdutoModel := TProdutoModel.Create;
end;

destructor TProdutoControl.Destroy;
begin
  FProdutoModel.Free;
  inherited;
end;

function TProdutoControl.GetId(AAutoIncrementar: Integer): Integer;
begin
   Result := FProdutoModel.GetId(AAutoIncrementar);
end;

function TProdutoControl.Obter: TFDQuery;
begin
   Result := FProdutoModel.Obter;
end;

function TProdutoControl.Salvar: Boolean;
begin
   Result := FProdutoModel.Salvar;
end;

end.
