module Infer
  module TernaryLogic
    class Kleenean
      def true?
        false
      end

      def false?
        false
      end

      def unknown?
        false
      end

      include Truth
    end

    class TrueClass < Kleenean
      def true?
        true
      end
    end

    class FalseClass < Kleenean
      def false?
        true
      end
    end

    class UnknownClass < Kleenean
      def unknown?
        true
      end
    end

    TRUE = TrueClass.new
    FALSE = FalseClass.new
    UNKNOWN = UnknownClass.new
  end
end
