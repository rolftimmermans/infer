module Infer
  module TernaryLogic
    module Truth
      def |(other)
        case
        when true? then self
        when false? then other
        when unknown?
          if other.true? then other else self end
        end
      end

      def &(other)
        case
        when true? then other
        when false? then self
        when unknown?
          if other.false? then other else self end
        end
      end
    end
  end
end
