require "./enumerables.rb"

describe Enumerable do
  let(:test_array1) { [11, 2, 3, 56] }
  let(:test_array2) { %w[a b c d] }
  let(:a) { %w[a b c d e f] }
  let(:c) { [18, 22, 3, 3, 53, 6] }
  let(:true_array) { [1, true, "hi", []] }
  let(:false_array) { [nil, false, nil, false] }
  let(:words) { %w[dog door rod blade] }
  let(:array) {
    [1, 2, 3, 5, 1, 7, 3, 4, 5, 7, 2, 3, 2, 0, 8, 8, 7, 8, 1, 6, 1, 1, 7, 2, 1, 2, 5, 8, 6, 0, 4, 5, 8, 2, 2, 5, 4,
     7, 3, 4, 3, 3, 8, 5, 1, 0, 3, 7, 5, 5, 7, 2, 6, 7, 7, 0, 4, 4, 0, 2, 0, 6, 6, 8, 1, 6, 8, 6, 2, 3, 6, 1, 5, 2,
     6, 7, 2, 5, 8, 2, 0, 7, 3, 2, 3, 6, 1, 2, 8, 3, 7, 0, 5, 0, 0, 2, 6, 1, 5, 2]
  }
  let(:my_each_output) { "" }
  let(:ary) { [1, 2, 4, 2] }
  let(:ar2) { [1, 2, 3, 4] }
  let(:proc_map) { proc { |x| x - 2 } }
  # block = -> do
  #   1
  # end

  describe "#my_each" do
    let(:ar1) { [] }
    let(:ar2) { [] }
    it "To each element do a block code" do
      expect((1..6).my_each { |x| ar1 << x }).to eql((1..6).each { |x| ar2 << x })
      expect(ar1).to eql(ar2)
    end

    # address later
    # it "To each element when empty" do
    #   expect(ary.my_each).to match(ary.each)
    # end

    it "To each with a block code" do
      block = proc { |num| my_each_output.concat(num.to_s) }
      expect(array.my_each(&block)).to eql(array.each(&block))
    end
  end

  describe "#my_each_with_index" do
    it "To each element do a block code" do
      expect(test_array1.my_each_with_index { |x, y| p "item: #{x}, index: #{y}" }).to eql(test_array1.each_with_index { |x, y| p "item: #{x}, index: #{y}" })
    end
  end

  describe "#my_select" do
    it "To select element do a block code" do
      expect(a.my_select { |v| v =~ /[aeiou]/ }).to eql(a.select { |v| v =~ /[aeiou]/ })
    end
    it "To select even numbers" do
      expect(c.my_select(&:even?)).to eql(c.select(&:even?))
    end
  end

  describe "#my_all?" do
    it "To check if all numbers are >= 3" do
      expect(c.my_all? { |x| x > 3 }).to eql(c.all? { |x| x > 3 })
    end
  end

  describe "#my_any?" do
    it "To check if any numbers are < 50" do
      expect(c.my_any? { |x| x < 50 }).to eql(c.any? { |x| x < 50 })
    end
  end

  describe "#my_none?" do
    it "To check if no one of the numbers are > 50" do
      expect(c.my_none? { |x| x > 52 }).to eql(c.none? { |x| x > 52 })
    end
  end

  describe "#my_count" do
    it "To count all the elements on the array" do
      expect(ary.my_count).to eql(ary.count)
    end

    it "To count all the elements on the array that are = to 2" do
      expect(ary.my_count(2)).to eql(ary.count(2))
    end

    it "To count all the elements on the array that are odd" do
      expect(ary.my_count { |x| x % 2 == 1 }).to eql(ary.count { |x| x % 2 == 1 })
    end
  end

  describe "#my_map" do
    it "To change all elements on the array" do
      expect(ar2.my_map { |x| x * x }).to eql(ar2.map { |x| x * x })
    end

    it "To change all elements on the array executing the proc instead of the block" do
      expect(ar2.my_map(proc_map) { |x| x * x }).to eql(ar2.map { |x| x - 2 })
    end
  end

  describe "#my_inject" do
    it "To add elements to each other: test parameter" do
      expect((5..10).my_inject(:+)).to eql((5..10).inject(:+))
    end

    it "To add elements to each other: test block" do
      expect((5..10).my_inject{ |sum, n| sum + n }).to eql((5..10).inject{ |sum, n| sum + n })
    end

    it "multiply elements to each other: test parameter" do
      expect((5..10).my_inject(1, :*)).to eql((5..10).inject(1, :*))
    end

    it "multiply elements to each other: test block" do
      expect((5..10).my_inject(1) { |product, n| product * n }).to eql((5..10).inject(1) { |product, n| product * n })
    end

    it "find the longuer words" do
      search = proc { |memo, word| memo.length > word.length ? memo : word }
      expect(['cat', 'sheep', 'bear'].my_inject(&search)).to eql(['cat', 'sheep', 'bear'].inject(&search))
    end
  end

end
