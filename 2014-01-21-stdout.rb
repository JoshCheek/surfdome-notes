# main page: https://github.com/JumpstartLab/curriculum/issues/822
#
# covered material from
#   https://github.com/JoshCheek/ruby-kickstart/tree/master/session1/notes
#   https://github.com/JoshCheek/ruby-kickstart/tree/master/session2/notes
#   http://tutorials.jumpstartlab.com/topics/testing/intro-to-tdd.html
# did challenges from
#   https://github.com/JumpstartLab/ruby-exercises/tree/master/command-query

# stdout
puts "hello world"
$stdout.puts "hello, world"

# p vs puts
puts "abc"
p    "abc"

# general case of output
File.open("smile", "w") do |file|
  file.puts "hello world"
end

# input
puts "Say something: "
you_said = $stdin.gets()
puts "You said #{you_said.inspect}"

# stderr
$stderr.puts "an error!"

def print_hello(stream=$stdout)
  stream.puts "hello"
end
