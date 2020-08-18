unit uClienteControl;

interface

uses
  uClienteModel, System.SysUtils, FireDAC.Comp.Client;

type
  TClienteControl = class
  private
    FClienteModel: TClienteModel;

  public
    constructor Create;
    destructor Destroy; override;

    function Salvar: Boolean;
    function Obter: TFDQuery;
    function GetId(AAutoIncrementar: Integer): Integer;

    property ClienteModel: TClienteModel read FClienteModel write FClienteModel;
  end;

implementation

{ TClienteControl }

constructor TClienteControl.Create;
begin
  FClienteModel := TClienteModel.Create;
end;

destructor TClienteControl.Destroy;
begin
  FClienteModel.Free;

  inherited;
end;

function TClienteControl.GetId(AAutoIncrementar: Integer): Integer;
begin
  Result := FClienteModel.GetId(AAutoIncrementar);
end;

function TClienteControl.Obter: TFDQuery;
begin
  Result := FClienteModel.Obter;
end;

function TClienteControl.Salvar: Boolean;
begin
  Result := FClienteModel.Salvar;
end;

end.
