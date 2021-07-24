module Network
using Random

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

function getNTransactions(node::Node, n::Int)
    sorted = sort(collect(values(node.pool)), by=x -> x.fee, rev=true)
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
        # Get transactions to verify
        transactions = getNTransactions(node, 1)

        # Get the previous block hash
        # prev_block = getPreviousBlock(node)

        # Mine by trying different nonces

        # If succesful, alert the network

        # Sleep a while
        sleep(0.5)
    end
end

function transact()
    # Select a random Node for inserting new transactions
    node = getRandomNode()

    while true
        # Create new transaction
        tx = Transaction(0, "aki", 0, "marc", 0, "hi", randstring(12), 1)

        # Add transaction to pool
        addTransaction(node, tx)

        # Sleep a while
        sleep(1)
    end
end

function observe()
    while true
        n_nodes = size(nodes, 1)
        n_tx_all = 0

        for n in nodes
            n_tx_all += length(n.pool)
        end

        println("Number of nodes: $(lpad(n_nodes, 7))")
        println("Number of pooled transactions: $(lpad(n_tx_all, 7))")

        # Sleep a while
        sleep(0.5)
        run(`clear`)
    end
end

end

# Init a transaction loop
@async Network.transact()

# Init an observer loop
@async Network.observe()

# Init a mining loop
@sync @async Network.mine()