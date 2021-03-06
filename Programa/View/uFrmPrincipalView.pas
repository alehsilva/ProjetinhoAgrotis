unit uFrmPrincipalView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uConexao, Vcl.StdCtrls, Vcl.ToolWin,
  Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus, System.Actions, Vcl.ActnList,
  Vcl.Menus,
  uFrmCliente, uFrmProduto, uFrmPedidoProduto, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, uFrmPedido,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Cliente1: TMenuItem;
    Produtos1: TMenuItem;
    Pedido1: TMenuItem;
    CadastrarPedido1: TMenuItem;
    Image1: TImage;
    Image2: TImage;
    procedure Cliente1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CadastrarPedido1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  VPedidoProduto: TPedidoProduto;
begin
  VPedidoProduto := TPedidoProduto.Create(Application);
  VPedidoProduto.ShowModal();
end;

procedure TForm1.CadastrarPedido1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmPedido, frmPedido);
  try
    frmPedido.ShowModal;
  finally
    frmPedido.Release;
  end;
end;

procedure TForm1.Cliente1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCadastroCliente, frmCadastroCliente);
  try
    frmCadastroCliente.ShowModal;
  finally
    frmCadastroCliente.Release;
  end;
end;

procedure TForm1.Produtos1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmCadastroProduto, frmCadastroProduto);
  try
    frmCadastroProduto.ShowModal;
  finally
    frmCadastroProduto.Release;

  end;
end;

initialization

end.
