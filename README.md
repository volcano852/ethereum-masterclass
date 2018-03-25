# ethereum-masterclass
Udemy Ethereum Masterclass

## Ethereum blockchain overview

First block is called genesis block (block 0) (genesis.json file)
Private net vs Main-net:
- You are in control
- Probably are the only node (more can join later)

New block is created by miners

How transaction is created ?
Data signed by private key makes a valid transaction

Private key: use to sign transaction
Public key: derived from the private key. Used to verify transcation.
Ethereum address: derived from the public key

geth (go implementation of ethereum client) will download the whole blockchain on the computer
The ethereum blockchain is saved on every computer running geth

Proof of Stake: you need to bring Ether to mine new blocks. Currently in testing phase with casper network to be live in 2018
Casper network will probably be a mix of PoW & PoS

## Smart contract

Smart contract: turing complete code running on the blockchain
- is a state machine
- Need transactions to change state. State change happens through mining through transactions
- Can do logic operations

Smart contract programming language: Solidity, Serpert, LLL all compiles to EVM assembly
Every node runs the same code (because all nodes have a copy of the blockchain)

Deployment of a new contract: write Solidity code -> Compile it to bytecode -> Send to network (transaction without a receiver).
Each new contract receive a new address
Interacting with a new contract by sending a transaction
Transaction in Ethereum can have a data field:
- the hash of the function name including the parameters (ex: interact with thisFunction(uint a,uintb b) => sha3('thisFunction(uint,uint)')
Now has better ways to do this

ABI used to interact: Application Binary Interface contains all the functions, parmeters & return values of the contract
ABI is a Json file
The smart contract on the block chain is a binary file

When a smart contract is deployed: you cannot change (immutable block chain)



