require File.expand_path('../../../spec_helper', __FILE__)

require 'hamster/list'

describe Hamster::List do

  [:to_a, :entries].each do |method|

    describe "##{method}" do

      describe "on a really big list" do

        before do
          @list = Hamster.interval(0, STACK_OVERFLOW_DEPTH)
        end

        it "doesn't run out of stack" do
          lambda { @list.to_a }.should_not raise_error
        end

      end

      [
        [],
        ["A"],
        ["A", "B", "C"],
      ].each do |values|

        describe "on #{values.inspect}" do

          before do
            @list = Hamster.list(*values)
            @result = @list.send(method)
          end

          it "returns #{values.inspect}" do
            @result.should == values
          end

          it "returns a mutable array" do
            @result.last.should_not == "The End"
            @result << "The End"
            @result.last.should == "The End"
          end

        end

      end

    end

  end

end
