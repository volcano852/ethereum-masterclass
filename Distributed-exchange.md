## Token management

```
addToken(string symbolName,address erc20TokenAddress) onlyowner
hasToken(string symbolName) constant returns(bool)
```

## Funds (token) management

```
depositToken(string symbolName, uint amount) 
withdrawToken(string symbolName, uint amount)
getBalance(string symbolName) constant returns(uint)
```

## Funds (ethereum) management

```
depositEther() payable
withdrawEther(uint amountInWei)
getEtherBalanceInWei() constant returns(uint)
```

## Place orders
```
buyToken(string symbolName,uint priceInWei, uint amount)
sellToken(string symbolName,uint priceInWei, uint amount)
```

## Order management
```
cancelOrder(string symbolName,bool isSellOrder,uint priceInWei,uint offerKey)
getSellOrderBook(string token) constant returns (uint[],uint[])
getBuyOrderBook(string token) constant returns (uint[],uint[])
```
