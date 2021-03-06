require File.expand_path('../../../spec_helper', __FILE__)

require 'hamster/list'

describe Hamster::List do

  describe "#grep" do

    it "is lazy" do
      lambda { Hamster.stream { fail }.grep(Object) { |item| item } }.should_not raise_error
    end

    describe "without a block" do

      [
        [[], []],
        [["A"], ["A"]],
        [[1], []],
        [["A", 2, "C"], ["A", "C"]],
      ].each do |values, expected|

        describe "on #{values.inspect}" do

          before do
            @list = Hamster.list(*values)
          end

          it "returns #{expected.inspect}" do
            @list.grep(String).should == Hamster.list(*expected)
          end

        end

      end

    end

    describe "with a block" do

      [
        [[], []],
        [["A"], ["a"]],
        [[1], []],
        [["A", 2, "C"], ["a", "c"]],
      ].each do |values, expected|

        describe "on #{values.inspect}" do

          before do
            @original = Hamster.list(*values)
            @result = @original.grep(String) { |item| item.downcase }
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

end
