# on the word-count exercism, use scan instead of split
"a.c.d'e".split(/\W/)     # => ["a", "c", "d", "e"]
"a.c.d'e".scan(/[\w']+/)  # => ["a", "c", "d'e"]

# default value on a hash
hash = Hash.new 0  # => {}
hash['a']          # => 0
hash               # => {}
hash['a'] += 1     # => 1
hash               # => {"a"=>1}

# heredoc's are ways to define strings
string = <<-HERE  # => "if grep fish /etc/shells\n  echo Found fish\nelse\n  echo Got nothing\nend\n"
if grep fish /etc/shells
  echo Found fish
else
  echo Got nothing
end
HERE

string  # => "if grep fish /etc/shells\n  echo Found fish\nelse\n  echo Got nothing\nend\n"

padding = ' ' * 5        # => "     "
padding + "some string"  # => "     some string"


value_lines = ['v1', 'v2', 'v3']
# => ["v1", "v2", "v3"]

key         = 'k1'                                    # => "k1"
key_lines   = [key] + [padding]*(value_lines.size-1)  # => ["k1", "     ", "     "]
# => ["k1", "     ", "     "]

key_lines.zip(value_lines)
# => [["k1", "v1"], ["     ", "v2"], ["     ", "v3"]]



