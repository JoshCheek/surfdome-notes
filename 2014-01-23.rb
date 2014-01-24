# Regexes
"" # <-- string
// # <-- regex

/abc/  # => /abc/

# find a match in a string
"hello, world"[0]          # => "h"
"hello, world"[0, 2]       # => "he"
"hello, world"[/l./]       # => "ll"
"hello, world".scan(/l./)  # => ["ll", "ld"]

# substitute a match
"123-456-789".sub  /-/, '|'  # => "123|456-789"
"123-456-789".gsub /-/, '|'  # => "123|456|789"
"123-456-789".gsub /\d/, ''  # => "--"
"123-456-789".gsub /\D/, ''  # => "123456789"

# caret matches beginning of line
# cash  matches end of line
# \A    matches beginning of string
# \Z    matches end of string
"ab\ncd".scan(/^./)   # => ["a", "c"]
"ab\ncd".scan(/\A./)  # => ["a"]
"ab\ncd".scan(/.$/)   # => ["b", "d"]
"ab\ncd".scan(/.\Z/)  # => ["d"]


# reduce
[1, 2, 3, 4].reduce(0) { |sum, n| sum + n }  # => 10
[1, 2, 3, 4].reduce(0, :+)                   # => 10

# verses each_with_object
['a', 'b', 'c'].reduce([]) do |reversed, current|
  reversed.unshift current
  []
end  # => []

['a', 'b', 'c'].each_with_object([]) do |current, reversed|
  reversed.unshift current
  []
end  # => ["c", "b", "a"]



