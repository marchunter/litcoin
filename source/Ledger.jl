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

    function Block(block_id, timestamp_created, transactions, previous_hash, proof_id)
        hash = sha2_256(string(transactions, previous_hash, proof_id))
        new(block_id, timestamp_created, transactions, parent_hash, bytes2hex(hash))
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

end

	function verify_block()
		# verify block size

		# verify hash
	end


	function append_block()
	end


	# Construct genesis block
	function Blockchain()
	end

end
