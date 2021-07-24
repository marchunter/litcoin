module Ledger

export Transaction, Block, Blockchain

using Dates
using SHA

struct Transaction
	sender_id::UInt32
	sender_name::String
	recipient_id::UInt32
	recipient_name::String
	quantity::Float32
	message::String
	signature::String

end


struct Block
    block_id::UInt32
    timestamp_created::DateTime
    transactions::Vector{Transaction}
    parent_hash::String
    hash::String
	proof_id::UInt32

    function Block(block_id, timestamp_created, transactions, parent_hash, proof_id)
        hash = sha2_256(string(transactions, parent_hash, proof_id))
        new(block_id, timestamp_created, transactions, parent_hash, bytes2hex(hash), proof_id)
    end
end


mutable struct Blockchain
    name::String
    timestamp_created::DateTime
    timestamp_updated::DateTime

    blocks::Vector{Block}

    max_block_size::UInt32
    difficulty_level::UInt32
    mining_reward::Float32

	function Blockchain(name, timestamp_created, timestamp_updated, blocks, max_block_size, difficulty_level, mining_reward)
		new(name, timestamp_created, timestamp_updated, blocks, max_block_size, difficulty_level, mining_reward)
	end

	# Construct genesis block
	function Blockchain(name, max_block_size=1, difficulty_level=0, mining_reward=0)
		timestamp_created = Dates.now()
		first_block = Block(42, timestamp_created, Transaction[], "Genesis block", 69)

		new(name, timestamp_created, timestamp_created, Block[first_block], max_block_size, difficulty_level, mining_reward)
	end

end

# Functions belonging to Blockchain struct

function verify_block()
	# verify block size

	# verify hash
end

function append_block()
end



end
