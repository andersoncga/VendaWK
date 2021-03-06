unit Model.Entidades.PedidosItens;

interface

uses
  Model.DAO.Interfaces;

type
  TPedidosItens = class
    private
      [weak]
      FParent : iDAOEntidade<TPedidosItens>;
      FNumero_Item    : Integer;
      FData_Pedido    : TDate;
      FNumero_Pedido  : Integer;
      FId_Produto     : Integer;
      FQtd            : Double;
      FPreco_Venda    : Double;

    public
      constructor Create(Parent: iDAOEntidade<TPedidosItens>);
      destructor Destroy; override;
      function Numero_Item(Value: Integer): TPedidosItens; overload;
      function Numero_Item: Integer; overload;
      function Numero_Pedido(Value: Integer): TPedidosItens; overload;
      function Numero_Pedido: Integer; overload;
      function Id_Produto(Value: Integer): TPedidosItens; overload;
      function Id_Produto: Integer; overload;
      function Qtd(Value: Double): TPedidosItens; overload;
      function Qtd: Double; overload;
      function Preco_Venda(Value: Double): TPedidosItens; overload;
      function Preco_Venda: Double; overload;
      function &End: iDAOEntidade<TPedidosItens>;
    end;

implementation

{ TPedidosItens }

function TPedidosItens.&End: iDAOEntidade<TPedidosItens>;
begin
  Result  :=  FParent;
end;

constructor TPedidosItens.Create(Parent: iDAOEntidade<TPedidosItens>);
begin
  FParent :=  Parent;
end;

destructor TPedidosItens.Destroy;
begin

  inherited;
end;

function TPedidosItens.Id_Produto(Value: Integer): TPedidosItens;
begin
  Result      :=  Self;
  FId_Produto :=  Value;
end;

function TPedidosItens.Id_Produto: Integer;
begin
  Result  :=  FId_Produto;
end;

function TPedidosItens.Numero_Item: Integer;
begin
  Result  :=  FNumero_Item;
end;

function TPedidosItens.Numero_Item(Value: Integer): TPedidosItens;
begin
  Result        :=  Self;
  FNumero_Item  :=  Value;
end;

function TPedidosItens.Numero_Pedido(Value: Integer): TPedidosItens;
begin
  Result          :=  Self;
  FNumero_Pedido  :=  Value;
end;

function TPedidosItens.Numero_Pedido: Integer;
begin
  Result  :=  FNumero_Pedido;
end;

function TPedidosItens.Preco_Venda: Double;
begin
  Result  :=  FPreco_Venda;
end;

function TPedidosItens.Preco_Venda(Value: Double): TPedidosItens;
begin
  Result        :=  Self;
  FPreco_Venda  :=  Value;
end;

function TPedidosItens.Qtd(Value: Double): TPedidosItens;
begin
  Result  :=  Self;
  FQtd    :=  Value;
end;

function TPedidosItens.Qtd: Double;
begin
  Result  :=  FQtd
end;

end.
