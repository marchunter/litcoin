module Network
using SHA
using Dates
using Random

include("./Ledger.jl")
using .Ledger: Transaction, Blockchain, Block, appendblock, gethash, checkdifficulty

mutable struct Node
    pool::Dict{String,Transaction}
    blockchain::Blockchain
    Node() = new(Dict{String,Transaction}(), Blockchain("litcoin"))
    #Node() = new(Dict{String,Transaction}())
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

function addBlock(node::Node, parent_hash::String, transactions::Vector{Transaction}, nonce::String)
    node.blockchain.append_block(parent_hash, transactions, nonce)
end

function mine()
    # Select a random Node for getting the blockchain data
    node = getRandomNode()

    # Start mining
    while true
        # Get transactions to verify
        transactions = getNTransactions(node, 5)

        # Get the previous block hash
        parent_hash = node.blockchain.blocks[1].hash

        # Mine by trying different nonces
        max_nonce = 2 ^ 32
        mined = false
        block = 0
        for i in 0:max_nonce
            nonce = randstring(64)
            block = Block(0, Dates.now(), transactions, parent_hash, nonce)
            if checkdifficulty(node.blockchain, block)
                mined = true
                break
            end
        end

        # If succesful, alert the network
        if mined
            accepted = appendblock(node.blockchain, block)
            if accepted
                #println("MINED")
            else
                println("NOPE")
            end
        end

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
        longest_block = 0

        for n in nodes
            n_tx_all += length(n.pool)
            longest_block = max(longest_block, size(n.blockchain.blocks, 1))
        end

        println("Number of nodes: $(lpad(n_nodes, 7))")
        println("Number of pooled transactions: $(lpad(n_tx_all, 7))")
        println("Longest block: $(lpad(longest_block, 7))")

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