# booleans in JSON
require 'json'  # => true

hash = {
  'abc' => 'true',   # => "true"
  'def' => 'false',  # => "false"
}                    # => {"abc"=>"true", "def"=>"false"}

JSON.parse JSON.dump hash  # => {"abc"=>"true", "def"=>"false"}
JSON.dump hash             # => "{\"abc\":\"true\",\"def\":\"false\"}"

# dealing with a boolean coming in either as true or false
# or "true" or "false"
def normalize_boolean(bool)
  return bool  if bool == true || bool == false
  return true  if bool == 'true'
  return false if bool == 'false'
end


# triple equals is for case statements
case 'a'                        # => "a"
when 'a'
when String
when Proc.new { |c| c == 'a' }
end                             # => nil

'a' === 'a'  # => true
'a' === 'b'  # => false

String === 'a'  # => true
String === 123  # => false

Proc.new { |c| c == 'a' } === 'a'  # => true
Proc.new { |c| c == 'b' } === 'a'  # => false


# folder structure for core extensions (monkey patching)
# btw, don't do this :P

# gem_name
# ├── lib
# │   ├── gem_name.rb
# │   └── gem_name
# │       └── core_extensions.rb
# └── spec

# problems with monkey patching:
#  * You define String#to_bool
#    Someone else defines String#to_bool
#    they're not defined exactly the same
#    you get unexpected behaviour
#  * Code loses portability
#  * Harder to upgrade



