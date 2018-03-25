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
