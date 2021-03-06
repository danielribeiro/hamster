require File.expand_path('../../../spec_helper', __FILE__)

require 'hamster/tuple'
require 'hamster/list'

describe Hamster::List do

  describe "#split_at" do

    it "is lazy" do
      lambda { Hamster.stream { fail }.split_at(1) }.should_not raise_error
    end

    [
      [[], [], []],
      [[1], [1], []],
      [[1, 2], [1, 2], []],
      [[1, 2, 3], [1, 2], [3]],
      [[1, 2, 3, 4], [1, 2], [3, 4]],
    ].each do |values, expected_prefix, expected_remainder|

      describe "on #{values.inspect}" do

        before do
          @original = Hamster.list(*values)
          @result = @original.split_at(2)
          @prefix = @result.first
          @remainder = @result.last
        end

        it "preserves the original" do
          @original.should == Hamster.list(*values)
        end

        it "returns a tuple with two items" do
          @result.is_a?(Hamster::Tuple).should == true
        end

        it "correctly identifies the matches" do
          @prefix.should == Hamster.list(*expected_prefix)
        end

        it "correctly identifies the remainder" do
          @remainder.should == Hamster.list(*expected_remainder)
        end

      end

    end

  end

end
