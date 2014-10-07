require_relative 'fixed_xor'

def repeating_key_xor(string, key)
	arr = []
	curr_key = Key.new(key)
	string.split('').each do |char|
		xored = char.ord ^ curr_key.get_next_char_cycle.ord
		arr << xored
	end
	arr
end

def decrypt_text(str,key)
	byte_arr = hex_decode(str)
	arr = []
	curr_key = Key.new(key)
	byte_arr.each do |char|
		xored = char.ord ^ curr_key.get_next_char_cycle.ord
		arr << xored
	end
	arr.map(&:chr).join
end


class Key
	attr_reader :key
	attr_accessor :current_char_index

	def initialize(str)
	 	@key = str
	 	@current_char_index = -1
	end

	def get_next_char_cycle
		@current_char_index = (@current_char_index + 1) % key.length
		@key[current_char_index]
	end

end

# p hex_encode(repeating_key_xor("Burning 'em, if you ain't quick and nimble
# I go crazy when I hear a cymbal", "ICE"))
# p decrypt_text(hex_encode(repeating_key_xor("Burning 'em, if you ain't quick and nimble
# I go crazy when I hear a cymbal", "ICE")), "ICE")
# p hex_encode(repeating_key_xor("AAAAAAAAAAAAAAAAAAAAAAAAAA", "ICE"))