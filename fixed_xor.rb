def xor(buf_1, buf_2)
	arr = []
	(buf_1.length / 2).times do |i|
		arr[i] = hex_decode(buf_1)[i] ^ hex_decode(buf_2)[i]
	end
	hex_encode(arr)
end

def hex_decode(str)
	str.scan(/../).map(&:hex)
end

def hex_encode(byte_arr)
	byte_arr.map {|byte| "%02x" % byte}.join
end
