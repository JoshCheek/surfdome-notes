# Struct is a constructor for a class
Struct.new(:name, :sugar).class # => Class

# above struct is equivalent to
class Cupcake
  # defines setter and getter for name and sugar
  attr_accessor :name, :sugar
  
  def initialize(name=nil, sugar=nil)
    @name  = name
    @sugar = sugar
  end
end

# modules as namespaces

module M1
  module M2
  end
end

class C1
  module M2
  end
end

M1::M2 # => M1::M2
C1::M2 # => C1::M2

# modules for inheritence

module Greeter
  def say_hello
    'hello!'
  end
end

class Person
  include Greeter
  def say_goodbye
    'goodbye!'
  end
end

Person.new.say_hello # => "hello!"

# last module included wins

class Human
  module Greeter1
    def hello() 'Hello, from Greeter1' end
  end
  
  module Greeter2
    def hello() 'Hello, from Greeter2' end
  end

  include Greeter2
  include Greeter1
end

Human.new.hello # => "Hello, from Greeter1"


# A common module: Enumerable

Array.ancestors # => [Array, Enumerable, Object, Kernel, BasicObject]
Hash.ancestors  # => [Hash, Enumerable, Object, Kernel, BasicObject]


# blocks are accessed as procs

p = Proc.new { 123 } # => #<Proc:0x007ff6b9a7e920@/Users/josh/code/JSL/surfdome/2014-01-22.rb:73>
p.call               # => 123

p = Proc.new { |n| n * 2 } # => #<Proc:0x007ff6b9a7e628@/Users/josh/code/JSL/surfdome/2014-01-22.rb:76>
p.call(10)                 # => 20


# methods raise exceptions if num arguments is wrong
# blocks don't care
def m()
end

begin
  m(1, 2, 3)
rescue => e
  e.message # => "wrong number of arguments (3 for 0)"
end

Proc.new { :something }.call(1, 2, 3) # => :something
Proc.new { |arg| :something }.call()  # => :something

def first_even(nums)
  nums.each do |num|
    return num if num.even?
  end
  nil
end
first_even [1,5,7,4,19,8] # => 4
first_even [1,5,7,19]     # => nil


# Enumerable is a module for performing common collection tasks
Array.ancestors.include? Enumerable # => true
Hash.ancestors.include? Enumerable  # => true
# http://rdoc.info/stdlib/core/Enumerable

# It defines methods like map, all? etc
  # to_a
    {1 => 2, 3 => 4}.to_a # => [[1, 2], [3, 4]]
    
  # sort/sort_by
    [1,5,3,9].sort # => [1, 3, 5, 9]

    user = Struct.new(:age)
    [ user.new(10),
      user.new(9),
      user.new(100)
      ].sort_by { |user| user.age }
      # => [#<struct age=9>, #<struct age=10>, #<struct age=100>]

  # count
    (1..10).count # => 10
    
  # find
    (1..10).find { |num| num.even? } # => 2
    
  # select
    (1..10).select { |num| num.even? } # => [2, 4, 6, 8, 10]
    (1..10).select { |num| num > 11 }  # => []
    
  # reject
    range = 1..10
    range.reject { |num| num.even? } # => [1, 3, 5, 7, 9]
    range                            # => 1..10

  # map
    (1..5).map { |num| num * 2 } # => [2, 4, 6, 8, 10]

  # inject/reduce
    (1..10).reduce(0) { |sum, crnt| sum + crnt }
      # => 55

  # group_by
    (1..10).group_by { |num| num % 3 } 
      # => {1=>[1, 4, 7, 10], 2=>[2, 5, 8], 0=>[3, 6, 9]}
  
  # first
    ['a', 'b'].first # => "a"
    
  # all?
    [1,2,3].all? { |num| num.even? } # => false
    [2,4,6].all? { |num| num.even? } # => true

  # any?
    [1,2,3].any? { |num| num == 3 } # => true
    [2,4,6].any? { |num| num == 3 } # => false
    
  # none?
    [1,2,3].none? { |num| num == 3 } # => false
    [2,4,6].none? { |num| num == 3 } # => true

  # min/max
    [1,5,-3,16,0].min # => -3
    [1,5,-3,16,0].max # => 16

  # include?
    (1..10).include? 5  # => true
    (1..10).include? 11 # => false

  # each_with_index
    ('a'..'d').each_with_index do |char, index|
      char   # => "a", "b", "c", "d"
      index  # => 0, 1, 2, 3
    end

  # each_slice
    (1..10).each_slice(3).to_a # => [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]]

  # take
    (1..10).take(5) # => [1, 2, 3, 4, 5]


# it works on #each
class Names
  include Enumerable
  def initialize(*names)
    @names = names
  end
  
  def each(&block)
    @names.each(&block)
  end
end

names = Names.new "Dinesh", "Paulo", "Francisco"
names.each do |name|
  name # => "Dinesh", "Paulo", "Francisco"
end

names.map { |name| name.upcase } # => ["DINESH", "PAULO", "FRANCISCO"]


# reading csv from a file CSV

require 'csv'
csv_data = File.read(File.expand_path '../2014-01-22.csv', __FILE__)
csv_data # => "age,size,quantity\n1,2,3\n4,5,6\n7,8,9\n"

# with headers
csv = CSV.parse(csv_data, headers: true)

csv.each do |row|
  row['age']       # => "1", "4", "7"
  row['size']      # => "2", "5", "8"
  row['quantity']  # => "3", "6", "9"
end

# read from the file directly
CSV.foreach(File.expand_path('../2014-01-22.csv', __FILE__), headers: true) do |row|
  row['age'] # => "1", "4", "7"
end

# make a new CSV
csv_data = ''
csv = CSV.new(csv_data)
csv << [1, 2, 3]
csv << [4, 5, 6]
csv << [7, 8, 9]
csv_data # => "1,2,3\n4,5,6\n7,8,9\n"

# make a new csv with headers
csv_data = ''
csv = CSV.new(csv_data, headers: true)
csv << [:age, :size, :quantity]
csv << [1, 2, 3]
csv << [4, 5, 6]
csv << [7, 8, 9]
csv_data  # => "age,size,quantity\n1,2,3\n4,5,6\n7,8,9\n"

