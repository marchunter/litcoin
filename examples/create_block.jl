include("../source/Ledger.jl")
using .Ledger
using Dates

dummy_transaction = Transaction(1000, "sender", 2000, "recepient", 10.20, "thanks", "mysignature")

first_block = Block(42, DateTime(0), Transaction[dummy_transaction, dummy_transaction], "previous_dude_made_some_string", 69)

println(first_block)

new_blockchain = Blockchain("dude")

old_blockchin = Blockchain("yomama", Dates.now(), Dates.now(), Block[first_block, first_block], 5, 3, 42)

