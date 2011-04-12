module Infer
  module Inferred
    class KindOf < InstanceOf
      def true?
        !false? and type != ::Object and type != ::BasicObject
      end

      def inspect
        if type == ::BasicObject
          "<anything>"
        else
          "<any #{type}>"
        end
      end
    end
  end
end
