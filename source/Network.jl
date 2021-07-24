module Network

include("./Ledger.jl")
using .Ledger: Transaction

export Pool, getNTransactions

struct Pool
    transactions::Vector{Transaction}
end

function getNTransactions(pool::Pool, n::UInt)
    sorted = sort(pool.transactions, by= x -> x.fee, rev=true)
    return sorted
    # return sorted[0 min(n, size(sorted, 0)]
end

end
