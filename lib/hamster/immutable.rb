require 'forwardable'

module Hamster

  module Immutable

    def self.included(klass)
      klass.extend(ClassMethods)
      klass.instance_eval do
        include InstanceMethods
      end
    end

    module ClassMethods

      def new(*args)
        super.freeze
      end

      def method_added(name)
        return unless /^(.*)!$/ === name
        original = :"___#{$1}_bang___"
        return if method_defined?(original)
        alias_method original, name
        module_eval(<<-METHOD, "(__IMMUTABLE__)", 1)
def #{name}(*args, &block)
  transform { #{original}(*args, &block) }
rescue Exception
  $@.delete_if{ |s| /^\\(__IMMUTABLE__\\):/ =~ s}
  Kernel::raise
end
METHOD
      end

    end

    module InstanceMethods

      extend Forwardable

      def immutable?
        frozen?
      end

      alias_method :__immutable_dup__, :dup
      private :__immutable_dup__

      def dup
        self
      end
      def_delegator :self, :dup, :clone

      protected

      def transform_unless(condition, &block)
        condition ? self : transform(&block)
      end

      def transform(&block)
        __immutable_dup__.tap { |copy| copy.instance_eval(&block) }.freeze
      end

    end

  end

end
