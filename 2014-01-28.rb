# how does method(&:something) work?

[*1..10].map(&:even?)  # => [false, true, false, true, false, true, false, true, false, true]
:even?.to_proc         # => #<Proc:0x007fe935164970>

# for symbols, to_proc looks like:
class MySymbol
  def to_proc
    Proc.new do |target|
      target.send self
    end
  end
end

:even?.to_proc.call 1  # => false
1.send :even?          # => false
1.even?                # => false

:even?.to_proc.call 2  # => true
2.send :even?          # => true
2.even?                # => true
