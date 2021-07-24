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
    transactions::Vector(Transaction)
    parent_hash::String

end

