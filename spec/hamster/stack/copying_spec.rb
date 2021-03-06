require File.expand_path('../../../spec_helper', __FILE__)

require 'hamster/stack'

describe Hamster::Stack do

  [:dup, :clone].each do |method|

    [
      [],
      ["A"],
      ["A", "B", "C"],
    ].each do |values|

      describe "on #{values.inspect}" do

        before do
          @stack = Hamster.stack(*values)
        end

        it "returns self" do
          @stack.send(method).should equal(@stack)
        end

      end

    end

  end

end
