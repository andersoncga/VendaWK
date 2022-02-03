unit View.Principal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Controller.Interfaces,
  Controller.Controller;

type
  TViewPrincipal = class(TForm)
    pnl_header: TPanel;
    lbl_client: TLabel;
    cbb_client: TComboBox;
    btn_new_pedido: TButton;
    pnl_body: TPanel;
    lb_cod_produto: TLabel;
    lbl_descricao: TLabel;
    lbl_vl_unit: TLabel;
    lbl_qtde: TLabel;
    lbl_total_pedido: TLabel;
    edt_produto: TEdit;
    edt_descricao_produto: TEdit;
    edt_preco_venda: TEdit;
    edt_qtde: TEdit;
    btn_new_produto: TButton;
    dbg_itens: TDBGrid;
    ds_itens: TDataSource;
    dbg_pedidos: TDBGrid;
    ds_pedidos: TDataSource;
    btn_cancelar_acao_item: TButton;
    procedure FormCreate(Sender: TObject);
    procedure dbg_pedidosCellClick(Column: TColumn);
    procedure btn_new_pedidoClick(Sender: TObject);
    procedure btn_new_produtoClick(Sender: TObject);
    procedure edt_produtoExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dbg_itensKeyPress(Sender: TObject; var Key: Char);
    procedure btn_cancelar_acao_itemClick(Sender: TObject);
    procedure dbg_itensDblClick(Sender: TObject);
    procedure dbg_itensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure Listar;
    procedure IncluirPedido;
    procedure IncluirItem;
    function RetornaId_Cliente(Index: Integer): Integer;
    procedure PreencheComboBox;
    procedure ListarItem(Pedido: Integer);
    procedure Busca_Produto(Produto: string);
    procedure LimparCampos;
    procedure EditarItem;
    procedure AlterarItem;
    procedure DesabilitaEditarItem(AStat: Boolean);
    procedure DeletarItem;

    var
      st_item : string;

  public
    { Public declarations }
    FController : iController;

  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

{$R *.dfm}

uses Helper.GlobalFunctions;

procedure TViewPrincipal.btn_cancelar_acao_itemClick(Sender: TObject);
begin
  DesabilitaEditarItem(True);
  LimparCampos;
end;

procedure TViewPrincipal.btn_new_pedidoClick(Sender: TObject);
begin
  if (cbb_client.ItemIndex<0) then begin
    ToastAlert('Atenção', 'Informe o cliente antes de incluir um novo pedido', taWarning);
    exit;
  end;

  IncluirPedido;
  ToastAlert('Sucesso', 'Pedido adicionado', taSuccess);
end;

procedure TViewPrincipal.btn_new_produtoClick(Sender: TObject);
begin
  if (edt_produto.Text='') then begin
    ToastAlert('Atenção', 'Informe o produto antes de incluir um novo item', taWarning);
    exit;
  end;

  if st_item='' then begin
    IncluirItem;
    ToastAlert('Sucesso', 'Item adicionado', taSuccess);
  end
  else if st_item='A' then begin
    AlterarItem;
    ToastAlert('Sucesso', 'Item alterado', taSuccess);
  end;
  LimparCampos;
  edt_produto.SetFocus;
end;

procedure TViewPrincipal.AlterarItem;
begin
  FController
    .Entidades
    .PedidosItens
      .This
        .Numero_Item(ds_itens.DataSet.FieldByName('numero_item').AsInteger)
        .Qtd(StrToInt(StringReplace(edt_qtde.Text,'.','',[])))
        .Preco_Venda(StrToFloat(StringReplace(edt_preco_venda.Text,'.','',[])))
      .&End
    .Atualizar;

  ListarItem(ds_pedidos.DataSet.FieldByName('numero_pedido').AsInteger);
  st_item :=  '';
  DesabilitaEditarItem(True);
end;

procedure TViewPrincipal.dbg_itensDblClick(Sender: TObject);
begin
  if ds_itens.DataSet.IsEmpty then
    exit;

  EditarItem;
end;

procedure TViewPrincipal.dbg_itensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ds_itens.DataSet.IsEmpty then
    exit;

  if Key=VK_DELETE then
    DeletarItem;
end;

procedure TViewPrincipal.dbg_itensKeyPress(Sender: TObject; var Key: Char);
begin
  if ds_itens.DataSet.IsEmpty then
    exit;

  if Key = #13 then
    EditarItem;
end;

procedure TViewPrincipal.DeletarItem;
begin
  if Application.MessageBox('Deseja realmente excluir o item?',
    'Atenção', MB_YESNO+MB_ICONINFORMATION+MB_DEFBUTTON2)=IDYES then begin
    FController
      .Entidades
      .PedidosItens
      .Excluir(ds_itens.DataSet.FieldByName('numero_item').AsInteger);

    ListarItem(ds_pedidos.DataSet.FieldByName('numero_pedido').AsInteger);
  end;
end;

procedure TViewPrincipal.dbg_pedidosCellClick(Column: TColumn);
begin
  dbg_itens.SelectedRows.Clear;
  dbg_pedidos.SelectedRows.CurrentRowSelected := True;
  FController
    .Entidades
    .PedidosItens
    .ListarPorId(ds_pedidos.DataSet.FieldByName('numero_pedido').AsInteger)
    .DataSet(ds_itens);
  if not ds_pedidos.DataSet.IsEmpty then
    lbl_total_pedido.Caption  :=
      'Total do Pedido R$ ' +
      FormatFloat('#,##0.00', ds_pedidos.DataSet.FieldByName('total_pedido').AsFloat)
  else
    lbl_total_pedido.Caption  :=
      'Total do Pedido R$ ';
end;

procedure TViewPrincipal.DesabilitaEditarItem(AStat: Boolean);
begin
  btn_cancelar_acao_item.Visible  :=  not AStat;
  cbb_client.Enabled              :=  AStat;
  btn_new_pedido.Enabled          :=  AStat;
  dbg_pedidos.Enabled             :=  AStat;
  edt_produto.Enabled             :=  AStat;
  dbg_itens.Enabled               :=  AStat;
end;

procedure TViewPrincipal.EditarItem;
begin
  edt_produto.Text            :=  ds_itens.DataSet.FieldByName('id_produto').AsString;
  edt_descricao_produto.Text  :=  ds_itens.DataSet.FieldByName('descricao').AsString;
  edt_qtde.Text               :=  ds_itens.DataSet.FieldByName('qtd').AsString;
  edt_preco_venda.Text        :=  ds_itens.DataSet.FieldByName('preco_venda').AsString;

  st_item                         :=  'A';
  DesabilitaEditarItem(False);
  edt_qtde.SetFocus;
end;

procedure TViewPrincipal.edt_produtoExit(Sender: TObject);
begin
  if (edt_produto.Text <> '') then
    Busca_Produto(edt_produto.Text);
end;

procedure TViewPrincipal.Busca_Produto(Produto: string);
var
  LCod: Integer;
  LProduto: TDataSource;
begin

  TryStrToInt(Produto, LCod);
  LProduto  :=  TDataSource.Create(Self);
  try
    FController
      .Entidades
      .Produtos
      .ListarPorId(LCod)
      .DataSet(LProduto);

    if not LProduto.DataSet.IsEmpty then begin
      edt_descricao_produto.Text  :=  LProduto.DataSet.FieldByName('descricao').AsString;
      edt_preco_venda.Text        :=  LProduto.DataSet.FieldByName('preco_venda').AsString;
    end
    else
    begin
      edt_produto.SetFocus;
      LimparCampos;
    end;

  finally
    LProduto.DisposeOf;
  end;
end;

procedure TViewPrincipal.LimparCampos;
begin
  edt_produto.Text            :=  '';
  edt_descricao_produto.Text  :=  '';
  edt_preco_venda.Text        :=  '0,00';
  edt_qtde.Text               :=  '1';
end;

procedure TViewPrincipal.FormCreate(Sender: TObject);
begin
  st_item     :=  '';
  FController :=  TController.New;
  Listar;
  ListarItem(ds_pedidos.DataSet.FieldByName('numero_pedido').AsInteger);
  PreencheComboBox;
end;

procedure TViewPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  with Sender do
//    if Key = #13 then begin
//      SelectNext(Sender as tWinControl, True, True);
//      Key := #0;
//    end;
end;

procedure TViewPrincipal.IncluirItem;
var
  LSoma : Double; 
begin
  LSoma := 0;
  
  FController
    .Entidades
    .PedidosItens
      .This
        .Numero_Pedido(ds_pedidos.DataSet.FieldByName('numero_pedido').AsInteger)
        .Id_Produto(StrToInt(edt_produto.Text))
        .Qtd(StrToInt(StringReplace(edt_qtde.Text, '.', '', [])))
        .Preco_Venda(StrToFloat(StringReplace(edt_preco_venda.Text, '.', '', [])))
      .&End
    .Inserir;

  ListarItem(ds_pedidos.DataSet.FieldByName('numero_pedido').AsInteger);

  ds_itens.DataSet.First;
  while not ds_itens.DataSet.Eof do begin
    LSoma :=  LSoma + (ds_itens.DataSet.FieldByName('qtd').AsFloat*ds_itens.DataSet.FieldByName('preco_venda').AsFloat);
    ds_itens.DataSet.Next; 
  end;
      
  FController
    .Entidades
    .Pedidos
      .This
        .Id_Cliente(ds_pedidos.DataSet.FieldByName('id_cliente').AsInteger)
        .Total_Pedido(LSoma)
        .Numero_Pedido(ds_pedidos.DataSet.FieldByName('numero_pedido').AsInteger)
      .&End
    .Atualizar;  

  Listar;
end;

procedure TViewPrincipal.ListarItem(Pedido: Integer);
begin
  FController
    .Entidades
    .PedidosItens
      .ListarPorId(Pedido)
    .DataSet(ds_itens);
end;

procedure TViewPrincipal.IncluirPedido;
begin
  FController
    .Entidades
    .Pedidos
      .This
        .Data_Pedido(Now)
        .Id_Cliente(RetornaId_Cliente(cbb_client.ItemIndex))
        .Total_Pedido(0)
      .&End
    .Inserir;

  Listar;
  ds_pedidos.DataSet.Last;
  ListarItem(ds_pedidos.DataSet.FieldByName('numero_pedido').AsInteger);
  edt_produto.SetFocus;
end;

procedure TViewPrincipal.Listar;
begin
  FController
    .Entidades
    .Pedidos
    .Listar
    .DataSet(ds_pedidos);
//  FController
//    .Entidades
//    .PedidosItens
//    .ListarPorId(ds_pedidos.DataSet.FieldByName('numero_pedido').AsInteger)
//    .DataSet(ds_itens);
end;

procedure TViewPrincipal.PreencheComboBox;
var
  Lista: TDataSource;
begin
  Lista :=  TDataSource.Create(Self);
  try

    FController
      .Entidades
      .Clientes
      .Listar
      .DataSet(Lista);

    Lista.DataSet.First;
    while not Lista.DataSet.Eof do begin
      cbb_client.Items.AddObject(
        Lista
          .DataSet
            .FieldByName('nome').AsString,
        TObject(
          Lista
            .DataSet
              .FieldByName('codigo').AsInteger
        )
      );
      Lista.DataSet.Next;
    end;

  finally
    Lista.DisposeOf;
  end;
end;

function TViewPrincipal.RetornaId_Cliente(Index: Integer): Integer;
begin
  Result := Integer(cbb_client.Items.Objects[Index]);
end;

end.
