module Infer
  module Inferred
    class Type
      class << self
        def create(type)
          TypeList.new new(type)
        end

        def any
          TypeList.new GenericType.new(BasicObject)
        end
      end

      include TernaryLogic

      attr_reader :type

      def initialize(type)
        @type = type
      end

      def ancestors
        @type.ancestors.select { |ancestor| ancestor.kind_of? Class }
      end

      def inspect
        @type.inspect
      end

      def eql?(other)
        self.class.eql? other.class and @type.eql? other.type
      end
      alias == eql?

      def hash
        [self.class, @type].hash
      end
    end

    class GenericType < Type
      def inspect
        "kind of #{super}"
      end
    end
  end
end
