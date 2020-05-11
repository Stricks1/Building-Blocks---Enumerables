# rubocop: disable Style/StringLiterals
require "./enumerables.rb"
array = [18, 22, 3, 3, 53, 6]

puts "each method"
p(array.each { |x| p "Element #{x}" })
puts "\n"
puts "my_each method"
p(array.my_each { |x| p "Element #{x}" })

puts "\n"
puts "each_with_index method"
p(array.each_with_index { |x, y| p "We have #{x} with index #{y}" })

puts "\n"
puts "my_each_with_index method"
p(array.my_each_with_index { |x, y| p "We have #{x} with index #{y}" })

puts "\n"
a = %w[a b c d e f]
puts "select method : #{a.select { |v| v =~ /[aeiou]/ }}\n\n" #=> ["a", "e"]
puts "select method my : #{a.my_select { |v| v =~ /[aeiou]/ }}\n\n" #=> ["a", "e"]

c = [18, 22, 3, 3, 53, 6]
puts "select method : #{c.select(&:even?)}\n\n"
puts "select method my : #{c.my_select(&:even?)}\n\n"

puts "all? method : #{c.all? { |x| x > 3 }}\n\n"
puts "all method my : #{c.my_all? { |x| x > 3 }}\n\n"

puts "select method : #{c.select(&:even?)}\n\n"
puts "select method my : #{c.my_select(&:even?)}\n\n"

puts "any? method : #{c.any? { |x| x < 50 }}\n\n"
puts "any method my : #{c.my_any? { |x| x < 50 }}\n\n"

puts "none? method : #{c.none? { |x| x > 52 }}\n\n"
puts "none method my : #{c.my_none? { |x| x > 52 }}\n\n"

ary = [1, 2, 4, 2]

puts "count method: #{ary.count}\n\n"
puts "my_count method: #{ary.my_count}\n\n"
puts "count method(2): #{ary.count(2)}\n\n"
puts "my_count method(2): #{ary.my_count(2)}\n\n"
puts "count method{ |x| x%2==1 }: #{ary.count(2)}\n\n"
puts "my_count method{ |x| x%2==1 }: #{ary.my_count(2)}\n\n"

ar2 = [1, 2, 3, 4]

puts "map method ar2.map { |x| x * x } #{ar2.map { |x| x * x }}\n\n"
puts "my_map method ar2.my_map { |x| x * x } #{ar2.my_map { |x| x * x }}\n\n"
puts "map method arr.map { |x| x * x } #{ar2.map { |x| x * x }}\n\n"
puts "map method arr.my_map { |x| x * x } #{ar2.my_map { |x| x * x }}\n\n"

proced_map = proc { |x| x * 2 }
puts "my_map procedure { |x| x * 2 }: #{ar2.my_map(proced_map)}\n\n"
puts "my_map with proc and block just do proc:"
p ar2.my_map(proced_map) { |x| x * x }

puts "(5..10).inject(:+)  #{(5..10).inject(:+)}\n\n"
puts "(5..10).my_inject(:+)  #{(5..10).my_inject(:+)}\n\n"

puts "(5..10).inject{ |sum, n| sum + n }    #{(5..10).inject { |sum, n| sum + n }}\n\n"
puts "(5..10).my_inject{ |sum, n| sum + n }    #{(5..10).my_inject { |sum, n| sum + n }}\n\n"

puts "(5..10).inject(1, :*):    #{(5..10).inject(1, :*)}\n\n"
puts "(5..10).my_inject(1, :*):    #{(5..10).my_inject(1, :*)}\n\n"

puts "(5..10).inject(1) { |product, n| product * n }:  #{(5..10).inject(1) { |product, n| product * n }}\n\n"
puts "(5..10).my_inject(1) { |product, n| product * n }:    #{(5..10).my_inject(1) { |product, n| product * n }}\n\n"

search = proc { |memo, word| memo.length > word.length ? memo : word }
puts "search = proc { |memo, word| memo.length > word.length ? memo : word }"

puts "['cat', 'sheep', 'bear'].inject(&search): #{%w[cat sheep bear].inject(&search)}\n\n"
puts "['cat', 'sheep', 'bear'].my_inject(&search): #{%w[cat sheep bear].my_inject(&search)}\n\n"

puts "multiply_els([2, 4, 5]): #{multiply_els([2, 4, 5])}"

# rubocop: enable Style/StringLiterals
