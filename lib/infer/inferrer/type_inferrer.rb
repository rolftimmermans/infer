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
        Inferred::Types.only literal.value.class
      end
      alias visit_ruby_nil visit_ruby_literal
      alias visit_ruby_true visit_ruby_literal
      alias visit_ruby_false visit_ruby_literal

      def visit_ruby_string(string)
        Inferred::Types.only String
      end

      def visit_ruby_hash(hash)
        Inferred::Types.only Hash
      end

      def visit_ruby_array(array)
        Inferred::Types.only Array
      end

      def visit_ruby_range(range)
        Inferred::Types.only Range
      end

      def visit_ruby_binary_operator(binary)
        case binary.operator.token
        when "or",  "||" then visit(binary.left) + visit(binary.right)
        when "and", "&&" then visit(binary.left) + visit(binary.right)
        else raise NotImplementedError
        end
      end

      def visit_string(string)
      end
    end
  end
end
