# require 'benchmark'
require_relative 'xor_cipher_cont'
require_relative 'repeating-key_xor'

# def bit_diff(byte_a, byte_b)
#   count_number_of_ones(byte_a ^ byte_b, 0)
# end

# # Recursive cuz it's cute. Still better than EZ MODE but would be better
# # if I could figure out how to turn TCO on.
# def count_number_of_ones(byte, res)
#   return res + byte if byte == 0 || byte == 1
#   binary_length = Math::log(byte, 2).floor
#   new_byte = byte - 2 ** binary_length
#   count_number_of_ones(new_byte, res + 1)
# end

# def bit_diff_ez_mode(byte_a, byte_b)
#   xored = byte_b ^ byte_a
#   xored.to_s(2).scan(/1/).length
# end

# Faster by an order of magnitude
# p bit_diff(15,6)
# p bit_diff_ez_mode(15,6)
# p bit_diff(33,30)
# p bit_diff_ez_mode(33,30)


# puts "Recursive:"
# puts Benchmark.measure { 100000.times do bit_diff(40, 6) end }
# puts "EZ MODE"
# puts Benchmark.measure { 100000.times do bit_diff_ez_mode(40,6) end }
# puts "Better"
# puts Benchmark.measure { 100000.times do bit_diff_better(40,6) end }


# test = 'this is a test'
# wokka = 'wokka wokka!!!'

# test_bit_arr = test.split('').map(&:ord).map {|byte| "%08b" % byte}.join.split('')
# wokka_bit_arr = wokka.split('').map(&:ord).map {|byte| "%08b" % byte}.join.split('')

class FuckChallenge6
  attr_accessor :key, :filename, :keysize


  def initialize(filename)
    @filename = filename
    @keysize = find_keysize
    @key = find_key
  end

  def hamming_dist(str_a,str_b)
    raise "Cannot compare strings with different lengths." unless str_a.length == str_b.length
    diff = 0
    (str_a.length).times do |i|
      diff += bit_diff_better(str_a[i].ord, str_b[i].ord)
    end
    diff
  end

  def bit_diff_better(byte_a, byte_b)
    dist = 0
    val = byte_b ^ byte_a
    while(val > 0)
      dist += 1
      val &= val-1
    end
    dist
  end

  def find_keysize
    min_dist = 100000
    probable_keysize = 0
    (2..40).each do |keysize|
      blocks = get_blocks(keysize, 4)
      blocks.each do |block|
        res1 = hamming_dist(blocks[0], blocks[1])
        res2 = hamming_dist(blocks[0], blocks[2])
        res3 = hamming_dist(blocks[0], blocks[3])
        res4 = hamming_dist(blocks[1], blocks[2])
        res5 = hamming_dist(blocks[1], blocks[3])
        res6 = hamming_dist(blocks[2], blocks[3]) 
        avg = (res1 + res2 + res3 + res4 + res5 + res6) / 6.0
        normalized = avg.to_f/keysize.to_f
        if normalized < min_dist
          min_dist = normalized
          probable_keysize = keysize
        end
      end
    end
    probable_keysize
  end

  def get_blocks(size_of_block, number_of_blocks)
    res = []
    number_of_blocks.times do |i|
      res << IO.binread(filename, size_of_block, i * size_of_block)
    end
    res
  end

  def splice_blocks
    res = [] 
    file_size = File.open(filename).size
    blocks = get_blocks(keysize, file_size/keysize)
    keysize.times do |i|
      arr = []
      blocks.each do |block|
        arr << block[i]
      end
      res << arr
    end
    res.map(&:join)
  end

  def find_key
    key = []
    splice_blocks.each do |str|
      key << find_likely_key(str)
    end
    key.join
  end

  def decrypt
    data = File.read(filename)
    decrypt_text(data,@key)
  end

end

fuck = FuckChallenge6.new('c6_encrypted.txt')
p fuck
p fuck.decrypt

