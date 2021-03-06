require File.expand_path('../../../spec_helper', __FILE__)

require 'hamster/list'

describe Hamster::List do

  describe "#drop" do

    it "is lazy" do
      lambda { Hamster.stream { fail }.drop(1) }.should_not raise_error
    end

    [
      [[], 10, []],
      [["A"], 10, []],
      [["A"], -1, ["A"]],
      [["A", "B", "C"], 0, ["A", "B", "C"]],
      [["A", "B", "C"], 2, ["C"]],
    ].each do |values, number, expected|

      describe "#{number} from #{values.inspect}" do

        before do
          @original = Hamster.list(*values)
          @result = @original.drop(number)
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
