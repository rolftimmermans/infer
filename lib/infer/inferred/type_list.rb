require "set"

module Infer
  module Inferred
    class TypeList
      attr_reader :types

      def initialize(types)
        @types = Set.new([*types])
      end
      
      def ==(other)
        @types == other.types
      end
    end
  end
end
