require File.expand_path('../../../spec_helper', __FILE__)

require 'hamster/list'

describe Hamster::List do

  [:uniq, :nub, :remove_duplicates].each do |method|

    describe "##{method}" do

      it "is lazy" do
        lambda { Hamster.stream { fail }.uniq }.should_not raise_error
      end

      [
        [[], []],
        [["A"], ["A"]],
        [["A", "B", "C"], ["A", "B", "C"]],
        [["A", "B", "A", "C", "C"], ["A", "B", "C"]],
      ].each do |values, expected|

        describe "on #{values.inspect}" do

          before do
            @original = Hamster.list(*values)
            @result = @original.send(method)
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
