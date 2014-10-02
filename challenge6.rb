require 'benchmark'

def hamming_dist(str_a,str_b)
  raise "Cannot compare strings with different lengths." unless str_a.length == str_b.length
  diff = 0
  (str_a.length).times do |i|
    diff += bit_diff_better(str_a[i].ord, str_b[i].ord)
  end
  diff
end

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
def bit_diff_better(byte_a, byte_b)
  dist = 0
  val = byte_b ^ byte_a
  while(val > 0)
    dist += 1
    val &= val-1
  end
  dist
end
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


p hamming_dist('this is a test', 'wokka wokka!!!')
test = 'this is a test'
wokka = 'wokka wokka!!!'

test_bit_arr = test.split('').map(&:ord).map {|byte| "%08b" % byte}.join.split('')
wokka_bit_arr = wokka.split('').map(&:ord).map {|byte| "%08b" % byte}.join.split('')

def count_stuff (arr_a, arr_b)
  diff = 0
  (arr_a.length - 1).times do |i|
    diff += 1 if arr_a[i] != arr_b[i]
  end
  diff
end

p count_stuff(test_bit_arr, wokka_bit_arr)
