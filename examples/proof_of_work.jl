
using SHA
using Random

block_string = "test5"
block_string = randstring(10)
#println(bytes2hex(sha256("test")))


max_nonce = 2 ^ 32 # 4 billion
max_nonce = 2 ^ 16

is_hash_found = 0
for nonce in 0:max_nonce           
    hash = bytes2hex(sha256(string(nonce) * block_string))
    #println(hash)
    if startswith(hash, "0000")
        global is_hash_found = 1
        println(hash)
        break
    end
end

if is_hash_found == 0
	println("no proper hash found, please try again later")
end

