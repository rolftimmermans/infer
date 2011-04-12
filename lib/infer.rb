$: << "~/Code/syntaxtree/lib"

require "infer/ternary_logic/truth"
require "infer/ternary_logic/kleenean"
require "infer/inferred/type"
require "infer/inferred/type_list"
require "infer/inferrer/type_inferrer"

# require "syntaxtree"
# require "syntax_tree/visitors/base"
# require "set"
#
# module Inferred
#   class Types
#     attr_reader :types
#
#     def initialize(types)
#       @types = Set.new([*types])
#     end
#
#     def +(other)
#       self.class.new @types + other.types
#     end
#
#     def push(type_or_value)
#       @types << type_or_value
#     end
#
#     def reduce
#       @types.inject(&:&)
#     end
#
#     def or(other)
#       case
#       when true?  then self
#       when false? then other
#       else             self + other
#       end
#     end
#
#     def and(other)
#       case
#       when true?  then other
#       when false? then self
#       else             self + other
#       end
#     end
#
#     def invert
#       case
#       when true?  then Value.false!
#       when false? then Value.true!
#       else             Value.true! + Value.false!
#       end
#     end
#
#     def true?
#       @types.all? &:true?
#     end
#
#     def false?
#       @types.all? &:false?
#     end
#   end
#
#   class Type
#     class << self
#       def create(type)
#         Types.new Type.new(type)
#       end
#     end
#
#     attr_reader :klass
#
#     def initialize(klass)
#       @klass = klass
#     end
#
#     def ancestors
#       @klass.ancestors.select { |mod| mod.kind_of? Class }
#     end
#
#     def inspect
#       @klass.inspect
#     end
#
#     def true?
#       @klass == TrueClass
#     end
#
#     def false?
#       @klass == NilClass or @klass == FalseClass
#     end
#
#     def &(other)
#       hierarchy = ancestors.reverse.zip(other.ancestors.reverse).reverse
#       self.class.new hierarchy.find { |a, b| a == b }.first
#     end
#
#     def eql?(other)
#       @klass.eql? other.klass
#     end
#
#     def hash
#       @klass.hash
#     end
#   end
#
#   class Value
#     class << self
#       def create(value)
#         Types.new Type.new(value.class)
#       end
#
#       def true!
#         create true
#       end
#
#       def false!
#         create false
#       end
#
#       def nil!
#         create nil
#       end
#     end
#   end
# end
#
# module Inferrer
#   class << self
#     def infer_types(src)
#       TypeInferrer.new(src).return_types
#     end
#   end
#
#   class TypeInferrer < SyntaxTree::Visitors::Base
#     def initialize(src)
#       @tree = SyntaxTree::RubyParser.parse(src)
#     end
#
#     def return_types
#       accept @tree
#     end
#
#     protected
#
#     def visit_ruby_program(program)
#       visit program.statements.last
#     end
#
#     def visit_ruby_literal(literal)
#       Inferred::Value.create(literal.value)
#     end
#
#     def visit_ruby_dynasymbol(symbol)
#       Inferred::Type.create(Symbol)
#     end
#
#     def visit_ruby_array(array)
#       Inferred::Type.create(Array)
#     end
#
#     def visit_ruby_hash(hash)
#       Inferred::Type.create(Hash)
#     end
#
#
#     def visit_ruby_class(klass)
#       visit(klass.body) # FIXME
#     end
#
#     def visit_ruby_method(method)
#       Inferred::Value.nil!
#     end
#
#
#
#     def visit_ruby_unary(unary)
#       case unary.operator.token
#       when "!"
#         visit(unary.operand).invert
#       else
#         raise NotImplementedError
#       end
#     end
#
#     def visit_ruby_binary(binary)
#       case binary.operator.token
#       when "or", "||"
#         visit(binary.left).or visit(binary.right)
#       when "and", "&&"
#         visit(binary.left).and visit(binary.right)
#       else
#         raise NotImplementedError
#       end
#     end
#
#
#     def visit_ruby_variable(variable)
#       Inferred::Type.create(Object)
#     end
#
#     def visit_ruby_call(method)
#       Inferred::Type.create(Object)
#     end
#
#
#     def visit_ruby_ifop(condition)
#       expression = visit(condition.condition)
#       left       = visit(condition.left)
#       right      = visit(condition.right)
#       case
#       when expression.true?  then left
#       when expression.false? then right
#       else                        left + right
#       end
#     end
#   end
# end
#
# p Inferrer.infer_types("3")
# # puts r.parse
