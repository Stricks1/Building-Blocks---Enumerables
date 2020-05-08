module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < length
      yield self[i]
      i += 1
    end
    self
  end
end

array = %w[4 3 78 2 0 2]
p(array.each { |x| print x + "-test\n" })

p(array.my_each { |x| print x + "-test\n" })
