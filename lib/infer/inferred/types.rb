require "set"

module Infer
  module Inferred
    class Types
      class << self
        def instance_of(type)
          new << InstanceOf.new(type)
        end
        alias only instance_of

        def kind_of(type)
          new << KindOf.new(type)
        end
        alias any kind_of

        def anything
          kind_of(BasicObject)
        end

        private :new
      end

      def initialize
        @instances_of, @kinds_of = Set.new, Set.new
      end

      def initialize_copy(original)
        super
        @instances_of = original.instances_of.dup
        @kinds_of = original.kinds_of.dup
      end

      def true?
        types.all? &:true?
      end

      def false?
        types.all? &:false?
      end

      def unknown?
        !true? and !false?
      end

      def +(other)
        dup.tap do |combined|
          combined.instances_of.merge other.instances_of
          combined.kinds_of.merge other.kinds_of
          combined.send :simplify
        end
      end

      def <<(type)
        case type
        when KindOf then kinds_of << type
        when InstanceOf then instances_of << type
        else raise TypeError, "Cannot add type #{type.class}"
        end
        self
      end

      def ==(other)
        instances_of == other.instances_of and kinds_of == other.kinds_of
      end

      def inspect
        "{#{types.collect.map(&:inspect).join(", ")}}"
      end

      protected

      attr_reader :instances_of, :kinds_of

      def types
        instances_of + kinds_of
      end

      private

      def simplify
        kinds_of_classes = kinds_of.map(&:type)
        instances_of.reject! { |instance| (kinds_of_classes & instance.ancestors).any? }
        kinds_of.reject! { |kind| (kinds_of_classes & kind.strict_ancestors).any? }
      end
    end
  end
end

require "infer/inferred/types/instance_of"
require "infer/inferred/types/kind_of"
require "infer/inferrer/type_inferrer"
