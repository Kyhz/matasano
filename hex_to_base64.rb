require 'base64'

hex = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
def encode(str)
	Base64.strict_encode64(str.scan(/../).map(&:hex).map(&:chr).join)
end