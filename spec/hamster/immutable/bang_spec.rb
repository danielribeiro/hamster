require File.expand_path('../../../spec_helper', __FILE__)

require 'hamster/immutable'

describe Hamster::Immutable do

  class Person < Struct.new(:first, :last)
    include Hamster::Immutable

    def public_set_first!(name)
      self.first = name
    end

    protected

    def protected_set_first!(name)
      self.first = name
    end

    private

    def private_set_first!(name)
      self.first = name
    end

  end

  [:public, :protected, :private].each do |visibility|

    describe "##{visibility}! methods" do

      before do
        @original = Person.new("Simon", "Harris")
        @result = @original.send("#{visibility}_set_first!", "Sampy")
      end

      it "preserves the original" do
        @original.first.should == "Simon"
        @original.last.should == "Harris"
      end

      it "returns a new instance with the updated values" do
        @result.first.should == "Sampy"
        @result.last.should == "Harris"
      end

    end

  end

end
