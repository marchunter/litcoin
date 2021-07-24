module Blockchain

export Transaction, Block

using Dates

struct Transaction
	sender_id::UInt32
	sender_name::String
	recipient_id::UInt32
	recipient_name::String
	quantity::Float32
	message::String

end


struct Block
    block_id::UInt32
    timestamp_created::DateTime
    transactions::Vector{Transaction}
    parent_hash::String
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

end
