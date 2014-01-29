# how does method(&:something) work?

[*1..10].map(&:even?)  # => [false, true, false, true, false, true, false, true, false, true]
:even?.to_proc         # => #<Proc:0x007fca641da8b8>

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


# ERB

shopping_cart = ['lamp', 'desk', 'pencils']  # => ["lamp", "desk", "pencils"]
template = "
<ul>
  <% shopping_cart.each do |item| %>
    <li><%= item %></li>
  <% end %>
</ul>
"  # => "\n<ul>\n  <% shopping_cart.each do |item| %>\n    <li><%= item %></li>\n  <% end %>\n</ul>\n"

require 'erb'                  # => true
puts ERB.new(template).result  # => nil

# >> 
# >> <ul>
# >>   
# >>     <li>lamp</li>
# >>   
# >>     <li>desk</li>
# >>   
# >>     <li>pencils</li>
# >>   
# >> </ul>
