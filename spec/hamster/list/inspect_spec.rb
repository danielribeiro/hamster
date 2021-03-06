require File.expand_path('../../../spec_helper', __FILE__)

require 'hamster/list'

describe Hamster::List do

  describe "#inspect" do

    describe "on a really big list" do

      before do
        @list = Hamster.interval(0, STACK_OVERFLOW_DEPTH)
      end

      it "doesn't run out of stack" do
        lambda { @list.inspect }.should_not raise_error
      end

    end

    [
      [[], "[]"],
      [["A"], "[\"A\"]"],
      [["A", "B", "C"], "[\"A\", \"B\", \"C\"]"]
    ].each do |values, expected|

      describe "on #{values.inspect}" do

        before do
          @list = Hamster.list(*values)
        end

        it "returns #{expected.inspect}" do
          @list.inspect.should == expected
        end

      end

    end

  end

end
