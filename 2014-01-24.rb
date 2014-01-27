# attribute reader for a class
class Whatever
  class << self
    attr_reader :some_value  # => nil
    def abc
      'first abc'
    end
  end
  def self.abc
    'second abc'             # => "second abc"
  end
  self                       # => Whatever
  @some_value = 123          # => 123
  some_value                 # => 123
  
  def something
    # @@some_value             # ~> NameError: uninitialized class variable @@some_value in Whatever
    Whatever.some_value      # => 123
  end
end

Whatever.some_value     # => 123
Whatever.new.something  # => 123
Whatever.abc            # => "second abc"


# generating methods with a similar structure
def greet(n)
  "Hello, #{n}!"
end

[:id, :description, :name].each do |type|
  define_singleton_method("greet_#{type}") do
    greet type
  end
end

greet_id            # => "Hello, id!"
greet_name          # => "Hello, name!"
greet_description   # => "Hello, description!"

