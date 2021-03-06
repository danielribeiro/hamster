require File.expand_path('../../../spec_helper', __FILE__)

require 'hamster/list'

describe Hamster::List do

  describe "#inits" do

    it "is lazy" do
      lambda { Hamster.stream { fail }.inits }.should_not raise_error
    end

    [
      [[], [[]]],
      [["A"], [[], ["A"]]],
      [["A", "B", "C"], [[], ["A"], ["A", "B"], ["A", "B", "C"]]],
    ].each do |values, expected|

      expected = expected.map { |x| Hamster.list(*x) }

      describe "on #{values.inspect}" do

        before do
          @original = Hamster.list(*values)
          @result = @original.inits
        end

        it "preserves the original" do
          @original.should == Hamster.list(*values)
        end

        it "returns #{expected.inspect}" do
          @result.should == Hamster.list(*expected)
        end

      end

    end

  end

end
