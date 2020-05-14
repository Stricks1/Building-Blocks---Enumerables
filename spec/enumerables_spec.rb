require "./enumerables.rb"

describe Enumerable do
  let(:test_array1) { [11, 2, 3, 56] }
  let(:test_array2) { %w[a b c d] }
  let(:true_array) { [1, true, "hi", []] }
  let(:false_array) { [nil, false, nil, false] }
  let(:words) { %w[dog door rod blade] }
  let(:array) {
    [1, 2, 3, 5, 1, 7, 3, 4, 5, 7, 2, 3, 2, 0, 8, 8, 7, 8, 1, 6, 1, 1, 7, 2, 1, 2, 5, 8, 6, 0, 4, 5, 8, 2, 2, 5, 4,
     7, 3, 4, 3, 3, 8, 5, 1, 0, 3, 7, 5, 5, 7, 2, 6, 7, 7, 0, 4, 4, 0, 2, 0, 6, 6, 8, 1, 6, 8, 6, 2, 3, 6, 1, 5, 2,
     6, 7, 2, 5, 8, 2, 0, 7, 3, 2, 3, 6, 1, 2, 8, 3, 7, 0, 5, 0, 0, 2, 6, 1, 5, 2]
  }
  let(:my_each_output) { "" }
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
    #   expect(item.my_each).to be(item.each)
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
end
