require "syntax_tree"
require "syntax_tree/visitors/base"

module Infer
  module Inferrer
    class TypeInferrer < SyntaxTree::Visitors::Base
      def initialize(src)
        @tree = SyntaxTree::RubyParser.parse(src)
      end

      def infer
        accept @tree
      end

      protected

      def visit_ruby_node(node)
        node.nodes.map { |node| visit(node) }.compact.inject(:+)
      end

      def visit_ruby_literal(literal)
        Inferred::Type.create literal.value.class
      end
      alias visit_ruby_nil visit_ruby_literal

      def visit_ruby_string(string)
        Inferred::Type.create String
      end

      def visit_ruby_hash(hash)
        Inferred::Type.create Hash
      end

      def visit_ruby_array(array)
        Inferred::Type.create Array
      end

      def visit_ruby_range(range)
        Inferred::Type.create Range
      end

      def visit_string(string)
      end
    end
  end
end
