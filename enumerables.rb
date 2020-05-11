# rubocop:disable Metrics/ModuleLength
module Enumerable
  def my_each
    ver_arr = is_a?(Range) ? to_a : self
    return to_enum unless block_given?

    i = 0
    while i < size
      yield ver_arr[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    ver_arr = is_a?(Range) ? to_a : self
    return to_enum unless block_given?

    i = 0
    while i < size
      yield ver_arr[i], i
      i += 1
    end
    self
  end

  def my_select
    ver_arr = is_a?(Range) ? to_a : self
    return to_enum unless block_given?

    new_array = []
    i = 0
    while i < size
      new_array << ver_arr[i] if yield ver_arr[i]
      i += 1
    end
    new_array
  end

  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Metrics/MethodLength

  def my_all?(*args)
    ver_arr = is_a?(Range) ? to_a : self
    i = 0
    some_null = false
    if block_given?
      while i < size
        some_null = true unless yield ver_arr[i]
        i += 1
      end
      return !some_null
    end
    if args.empty?
      while i < size
        some_null = true if ver_arr[i] == false || ver_arr[i].nil?
        i += 1
      end
    elsif args.first.class == Class
      while i < size
        some_null = true unless ver_arr[i].is_a?(args.first)
        i += 1
      end
    elsif args.first.is_a?(Regexp)
      while i < size
        some_null = true unless args.first.match(ver_arr[i])
        i += 1
      end
    else
      while i < size
        some_null = true unless args.first == ver_arr[i]
        i += 1
      end
    end
    !some_null
  end

  def my_any?(*args)
    ver_arr = is_a?(Range) ? to_a : self
    i = 0
    if block_given?
      while i < size
        return true if yield ver_arr[i]

        i += 1
      end
      return false
    end
    if args.empty?
      while i < size
        return true if ver_arr[i] != false && !ver_arr[i].nil?

        i += 1
      end
    elsif args.first.class == Class
      while i < size
        return true if ver_arr[i].is_a?(args.first)

        i += 1
      end
    elsif args.first.is_a?(Regexp)
      while i < size
        return true if args.first.match(ver_arr[i])

        i += 1
      end
    else
      while i < size
        return true if args.first == ver_arr[i]

        i += 1
      end
    end
    false
  end

  def my_none?(*args)
    ver_arr = is_a?(Range) ? to_a : self
    i = 0
    if block_given?
      while i < size
        return false if yield ver_arr[i]

        i += 1
      end
      return true
    end
    if args.empty?
      while i < size
        return false if ver_arr[i] != false && !ver_arr[i].nil?

        i += 1
      end
    elsif args.first.class == Class
      while i < size
        return false if ver_arr[i].is_a?(args.first)

        i += 1
      end
    elsif args.first.is_a?(Regexp)
      while i < size
        return false if args.first.match(ver_arr[i])

        i += 1
      end
    else
      while i < size
        return false if args.first == ver_arr[i]

        i += 1
      end
    end
    true
  end

  def my_count(*args)
    ver_arr = is_a?(Range) ? to_a : self
    return size if args.size.zero? && !block_given?

    i = 0
    cont = 0
    unless block_given?
      while i < size
        cont += 1 if ver_arr[i] == args[0]
        i += 1
      end
      return cont
    end
    while i < size
      cont += 1 if yield ver_arr[i]
      i += 1
    end
    cont
  end

  # rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Metrics/MethodLength

  def my_map(proc_my = nil)
    ver_arr = is_a?(Range) ? to_a : self
    return to_enum if !block_given? && proc_my.nil?

    map_array = []
    i = 0
    while i < size
      map_array << (!proc_my.nil? ? proc_my.call(ver_arr[i]) : (yield ver_arr[i]))
      i += 1
    end
    map_array
  end

  # rubocop:disable Style/StringLiterals,Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

  def my_inject(*args)
    ver_arr = is_a?(Range) ? to_a : self
    return "no block or args given" if args.empty? && !block_given?

    return args.last.to_s + " is not a symbol" if args.last.class != Symbol && !block_given?

    if args.first.class != Symbol && args.first.class != NilClass
      sum = args.first
      i = 0
    else
      sum = ver_arr[0]
      i = 1
    end

    if !block_given?
      while i < size
        sum = sum.send(args.last.to_s, ver_arr[i])
        i += 1
      end
    else
      ver_arr.shift if args.first.class == NilClass
      ver_arr.my_each { |x| sum = yield sum, x }
    end

    sum
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end

# rubocop:enable Style/StringLiterals,Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Metrics/ModuleLength
