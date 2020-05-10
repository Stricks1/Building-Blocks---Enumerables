# rubocop:disable Metrics/ModuleLength
module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < size
      yield self[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < size
      yield self[i], i
      i += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    new_array = []
    i = 0
    while i < size
      new_array << self[i] if yield self[i]
      i += 1
    end
    new_array
  end

  # rubocop:disable Metrics/CyclomaticComplexity

  def my_all?
    i = 0
    some_null = false
    unless block_given?
      while i < size
        some_null = true if self[i] == false || self[i].nil?
        i += 1
      end
      return !some_null
    end
    while i < size
      some_null = true unless yield self[i]
      i += 1
    end
    !some_null
  end

  def my_any?
    i = 0
    unless block_given?
      while i < size
        return true if self[i] != false && !self[i].nil?

        i += 1
      end
      return false
    end
    while i < size
      return true if yield self[i]

      i += 1
    end
    false
  end

  def my_none?
    i = 0
    unless block_given?
      while i < size
        return false if self[i] != false && !self[i].nil?

        i += 1
      end
      return true
    end
    while i < size
      return false if yield self[i]

      i += 1
    end
    true
  end

  # rubocop:disable Metrics/PerceivedComplexity

  def my_count(*args)
    return size if args.size.zero? && !block_given?

    i = 0
    cont = 0
    unless block_given?
      while i < size
        cont += 1 if self[i] == args[0]
        i += 1
      end
      return cont
    end
    while i < size
      cont += 1 if yield self[i]
      i += 1
    end
    cont
  end

  # rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

  def my_map
    return to_enum unless block_given?

    map_array = []
    i = 0
    while i < size
      map_array << (yield self[i])
      i += 1
    end
    map_array
  end
end

# rubocop:enable Metrics/ModuleLength

# array = %w[4 3 78 2 0 2]

# p(array.each { |x| p "Element #{x}" })
# p(array.my_each { |x| p "Element #{x}" })

# p(array.each_with_index { |x, y| p "We have #{x} with index #{y}" })
# p(array.my_each_with_index { |x, y| p "We have #{x} with index #{y}" })

# a = %w[a b c d e f]
# puts "select method : #{a.select { |v| v =~ /[aeiou]/ }}\n\n" #=> ["a", "e"]
# puts "select method my : #{a.my_select { |v| v =~ /[aeiou]/ }}\n\n" #=> ["a", "e"]

# c = [18, 22, 3, 3, 53, 6]
# puts "select method : #{c.select(&:even?)}\n\n"
# puts "select method my : #{c.my_select(&:even?)}\n\n"

# puts "all? method : #{c.all? { |x| x > 3 }}\n\n"
# puts "all method my : #{c.my_all? { |x| x > 3 }}\n\n"

# puts "select method : #{c.select(&:even?)}\n\n"
# puts "select method my : #{c.my_select(&:even?)}\n\n"

# puts "any? method : #{c.any? { |x| x < 50 }}\n\n"
# puts "any method my : #{c.my_any? { |x| x < 50 }}\n\n"

# puts "none? method : #{c.none?{ |x| x > 52 }}\n\n"
# puts "none method my : #{c.my_none?{ |x| x > 52 }}\n\n"

# ary = [1, 2, 4, 2]

# p ary.my_count
# p ary.my_count(2)
# p ary.my_count{ |x| x%2==1 }

# ary = [1, 2, 3, 4]

# ary.map { |i| i*i }
