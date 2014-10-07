require_relative 'fixed_xor'

hex_ciphered = '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'

def single_byte_decode(encoded_string, char)
	arr = []
	byte_arr = hex_decode(encoded_string)
	byte_arr.each do |byte|
		a = byte ^ char.ord
		arr << a
	end
	arr
end

$char_freq = { :a => 0.08167,
			  :b => 0.01492,
			  :c => 0.02782,
			  :d => 0.04253,
			  :e => 0.12702,
			  :f => 0.02228,
			  :g => 0.02015,
			  :h => 0.06094,
			  :i => 0.06966,
			  :j => 0.00153,
			  :k => 0.00772,
			  :l => 0.04025,
			  :m => 0.02406,
			  :n => 0.06749,
			  :o => 0.07507,
			  :p => 0.01929,
			  :q => 0.00095,
			  :r => 0.05987,
			  :s => 0.06327,
			  :t => 0.09056,
			  :u => 0.02758,
			  :v => 0.00978,
			  :w => 0.02360,
			  :x => 0.00150,
			  :y => 0.01974,
			  :z => 0.00074 }

# ranking = {}
def grade_candidates(hex_str)
	ranking = Hash.new
	(0..127).each do |char|
		decoded = single_byte_decode(hex_str, char)
		grade = 0
		decoded.map(&:chr).map(&:downcase).each do |char|
			if $char_freq[char.chr]
				grade += $char_freq[char.chr] 
			elsif char == ' '
				grade += 0.1
			else
				grade -= 0.5
			end
		end
		ranking[grade] = char
	end
	ranking
end

# p single_byte_decode(hex_ciphered, 'x').map(&:chr).join.downcase
# p 0.chr.to_s

def hash_sort_by_key(hash)
	sorted_hash = Hash.new
	keys = hash.keys.sort.reverse
	keys.each do |key|
		sorted_hash[key] = hash[key]
	end
	sorted_hash
end

# p single_byte_decode(hex_ciphered, hash_sort_by_key(grade_candidates(hex_ciphered)).first[1]).map(&:chr).join