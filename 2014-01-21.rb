# single vs double quotes
# two different literals for making Strings
"abc\n"  # => "abc\n"
'abc\n'  # => "abc\\n"

# interpolation
name = 'Orest'          # => "Orest"
"hello, #{name}!"       # => "hello, Orest!"
"hello, " + name + "!"  # => "hello, Orest!"
'hello, #{name}!'       # => "hello, \#{name}!"

# inspect vs to_s
"abc".to_s     # => "abc"
"abc".inspect  # => "\"abc\""

# nil is a singleton
nil.object_id  # => 8
nil.object_id  # => 8

# nil and false are falsy
# everything else is true
"its true" if true          # => "its true"
"its true" if false         # => nil
"its true" if nil           # => nil
"its true" if "a"           # => "its true"
"its true" if nil == false  # => nil

# ||
# if the LHS is truthy, return it
# otherwise return RHS
true  || true   # => true
true  || false  # => true
false || "a"    # => "a"
"a"   || false  # => "a"
false || nil    # => nil

# &&
# if the LHS is falsy, return it
# otherwise return RHS
true  && true   # => true
true  && false  # => false
false && "a"    # => false
nil   && "a"    # => nil
true  && "a"    # => "a"

# multiline if statement
if false    # => false
  "a"
elsif true  # => true
  "b"       # => "b"
else
  "c"
end         # => "b"


# array literal
ary = ['a', 'b', 'c', 'd']  # => ["a", "b", "c", "d"]
ary[0]                      # => "a"
ary[1]                      # => "b"
ary[2]                      # => "c"
ary[-1]                     # => "d"
ary[5]                      # => nil
ary[1, 2]                   # => ["b", "c"]

# iterate with each
reverse_ary = []                   # => []
ary.each do |c|                    # => ["a", "b", "c", "d"]
  reverse_ary = [c] + reverse_ary  # => ["a"], ["b", "a"], ["c", "b", "a"], ["d", "c", "b", "a"]
end                                # => ["a", "b", "c", "d"]
reverse_ary                        # => ["d", "c", "b", "a"]

# enumerable example: map
ary.map { |c| c.upcase }  # => ["A", "B", "C", "D"]
ary                       # => ["a", "b", "c", "d"]

# SomeClass.new delegates its args to SomeClass#initialize
class SomeClass
  def initialize(name)
    @name = name        # => "Elizabetha"
  end
end

SomeClass.new("Elizabetha")  # => #<SomeClass:0x007ff38d3587d8 @name="Elizabetha">

# symbols begin with a colon
:symbol  # => :symbol

# only ever one instance
:abc.object_id   # => 465608
:abc.object_id   # => 465608
'abc'.object_id  # => 70342011437500
'abc'.object_id  # => 70342011437380

# hash litaral
hash = {
  :key1 => :value1,  # => :value1
  :key2 => :value2   # => :value2
}                    # => {:key1=>:value1, :key2=>:value2}

hash[:key1]               # => :value1
hash[:key1] = :value3     # => :value3
hash                      # => {:key1=>:value3, :key2=>:value2}
hash.[]=(:key1, :value4)  # => :value4
hash                      # => {:key1=>:value4, :key2=>:value2}

# when key is a symbol
hash = {
  key1: :value1,  # => :value1
  key2: :value2   # => :value2
}                 # => {:key1=>:value1, :key2=>:value2}
hash              # => {:key1=>:value1, :key2=>:value2}

hash.each do |key, value|  # => {:key1=>:value1, :key2=>:value2}
  key                      # => :key1, :key2
  value                    # => :value1, :value2
end                        # => {:key1=>:value1, :key2=>:value2}








