module Infer
  module Inferred
    class InstanceOf
      include TernaryLogic

      attr_reader :type

      def initialize(type)
        @type = type
      end

      def ancestors
        type.ancestors.select { |ancestor| ancestor.instance_of? Class }
      end

      def strict_ancestors
        ancestors[1..-1]
      end

      def true?
        !false?
      end

      def false?
        type == ::FalseClass or @type == ::NilClass
      end

      def unknown?
        !true? and !false?
      end

      def inspect
        type.to_s
      end

      def eql?(other)
        self.class.eql? other.class and type.eql? other.type
      end
      alias == eql?

      def hash
        [self.class, type].hash
      end
    end
  end
end
