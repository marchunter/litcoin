module Network

include("./Blockchain.jl")
using .Blockchain: Transaction, Blockchain

mutable struct Node
    pool::Dict{String,Transaction}
    blockchain::Blockchain
    Node() = new(Dict{String,Transaction}(), Blockchain())
end

nodes::Vector{Node}

function getNTransactions(pool::Pool, n::UInt)
    sorted = sort(pool.transactions, by= x -> x.fee, rev=true)
    return sorted
    # return sorted[0 min(n, size(sorted, 0)]
end

function getRandomNode(nodes::Vector{Node})
    return nodes[rand(1:size(nodes, 0))]
end

function addTransaction(tx::Transaction)
    node.pool[tx.signature] = tx
end

function mine()
    # Select a random Node for getting the blockchain data
    node = getRandomNode()

    # Start mining
    while true
        print("mine")
        # Get transactions to verify
        transactions = getNTransactions(node, 1)

        # Get the previous block hash
        # prev_block = getPreviousBlock(node)

        # Mine by trying different nonces

        # If succesful, alert the network
    end
end

function transact()
    while true
        print("buy")
        # Create new transaction
        tx = Transaction(0, "aki", 0, "marc", 0, "hi", "kjehkjeh")

        # Add transaction to pool
        addTransaction(tx)

        # Wait for transaction to complete
    end
end

end

# Init a transaction loop
@async Network.transact()

# Init a mining loop
@sync @async Network.mine()