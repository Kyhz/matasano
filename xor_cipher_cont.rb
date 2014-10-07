require_relative 'single_char_xor_cipher'

def find_encrypted_likely(filename)
	encrypted_strings = File.open(filename)
	prob_key = []
	encrypted_strings.each_line do |line|
		prob_key << find_likely_key(line)
	end
	prob_key
end


def find_likely_key(str)
	hash_sort_by_key(grade_candidates(str)).first[1].chr
end

# lines = File.readlines('single_char_xor.txt')
# find_encrypted_likely('single_char_xor.txt').each_with_index do |char,i|
# 	p single_byte_decode(lines[i], char).map(&:chr).join
# end