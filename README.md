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

## Blockchain nodes

Geth (written in go), Ethereum-Cpp, Parity (written in Rust), MetaMask (Chrome plug in bridge)
Simulation of Ethereum protocol : EthereumJs-TestRPC to unit test smart contracts. Mining is simulated
Full nodes vs Light client
Full nodes download the whole blockchain vs Light client download only the headers

starting geth open UDP port 30303.
Will put an IPC file in the datadir directory for the other processes to communicate with geth

EthereumJs-TestRPC installed by npm

MetaMask is a chrome plugin (bridge)
Store private keys and can sign transactions
Does not download the chain data, discuss with the MetaMask server (and then we need to trust them :-) )

## Difference between a call & a transaction

Transaction:
- published to the network
- processed by miners
- if valid miners publish it on the blockchain
- Is a write transaction(update the state, use ether (gas))
- Asynchronous operation: the result-value is the hash of the transaction (need to wait then until the transaction is mined)

Call:
- read only operation
- local and free (does not consume gas)
- synchronous (return value is returned immediately)
- 'constant' keyword in a solidity contract

Do contracts create transactions ?
- Call (readonly): Local contract call (synchronous, cost no gas). Contract A calls Contracts B (synchronous, cost no gas)
- Transactions (write): Contract direct invocation : OK. Contract A -> Contract B. Who is the caller ??
Ethereum yellow paper says this is the same transaction. The same miner will work on the same transaction and one single return-value
Transactions between contracts are mined within the same block and returned all together

## Genesis.conf file

difficulty: how difficult is it to mine a block
gasLimit: any transaction to the transaction requires to pay gas to the miners. gasLimit defines the upper limit of the assembler opcodes miners are allowed to do. Still very hard to write complex code because of this limit
nounce and mixHash defines the blockchain
parentHash: sets to 0 for the first block
alloc: could gives ether to pre defined accounts
config.chainId: don't set to 1 because this is the mainnet

should create an empty directory called 'chaindata' to host the block chain

1. Initialize the private blockchain
geth --datadir=./chaindata/ init ./genesis.json 
2. Start geth with the new blockchain
geth --datadir=./chaindata/

## Ganache-CLI

install ganache-cli : npm install -g ganache-cli
ganache-cli: creates 10 accounts and shows the private keys, add 100 ether to each account, displays mnemonic and runs http server
ganache-cli -m "weasel champion mountain carry number spawn tissue ten basic mom ritual mechanic"

## Web3.js and the communication between the browser and geth

run geth with CORS:
geth --datadir=./chaindata/ console --rpc --rpccorsdomain "*"
Web3.js abstracts the JsonRPC.It does the encoding/decoding automatically. Of course ethereum client must be running (geth or ganache) 

## Mist & Ethereum wallet
Mist is an electron app which starts geth on the background. It gives access to Web3 through the browsing option.
Ehereum wallet is a DApp written in pure HTML/Js and uses Web3.js
It can manage accounts and deploy new contracts. It runs inside MIST browser but can also run as a standalone product
With MetaMask plugin in chrome wallet.ethereum.org runs inside Chrome
run mist with private net on Mac
run geth with private net : geth --datadir=....
/Applications/Mist.app/Contents/MacOS/Mist --rpc /Users/fabien/Code/privateEth/chaindata/geth.ipc --node-networkid 1234 --node-datadir ~/Library/Ethereum/privatenet
