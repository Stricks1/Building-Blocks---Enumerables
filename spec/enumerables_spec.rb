require "./enumerables.rb"

describe Enumerable do
  describe "#my_each" do
    let(:item) { (1..6) }
    let(:ar1) { [] }
    let(:ar2) { [] }
    it "To each element do a block code" do
      expect((1..6).my_each { |x| ar1 << x }).to eql((1..6).each { |x| ar2 << x })
      expect(ar1).to eql(ar2)
    end
    it "To each element when empty" do
      expect(item.my_each).to eql(item.each)
    end
  end
end
