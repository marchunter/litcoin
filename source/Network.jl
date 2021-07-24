module Network

include("./Ledger.jl")
using .Ledger: Transaction, Blockchain

mutable struct Node
    pool::Dict{String,Transaction}
    #blockchain::Blockchain
    #Node() = new(Dict{String,Transaction}(), Blockchain())
    Node() = new(Dict{String,Transaction}())
end

# Initialize a fixed number of nodes
nodes = [Node() for i in 1:10]

function getNTransactions(node::Node, n::UInt)
    sorted = sort(node.pool, by= x -> x.fee, rev=true)
    return sorted[1:min(n, size(sorted, 1))]
end

function getRandomNode()
    return nodes[rand(1:size(nodes, 1))]
end

function addTransaction(node::Node, tx::Transaction)
    node.pool[tx.signature] = tx
end

function mine()
    # Select a random Node for getting the blockchain data
    node = getRandomNode()

    # Start mining
    while true
        print("mine")
        # Get transactions to verify
        # transactions = getNTransactions(node, 1)

        # Get the previous block hash
        # prev_block = getPreviousBlock(node)

        # Mine by trying different nonces

        # If succesful, alert the network
    end
end

function transact()
    # Select a random Node for inserting new transactions
    node = getRandomNode()

    while true
        print("buy")
        # Create new transaction
        tx = Transaction(0, "aki", 0, "marc", 0, "hi", "kjehkjeh")

        # Add transaction to pool
        addTransaction(node, tx)

        # Wait for transaction to complete
    end
end

end

# Init a transaction loop
@async Network.transact()

# Init a mining loop
@sync @async Network.mine()