$: << File.expand_path("../lib", File.dirname(__FILE__))
require "bundler/setup"

require "infer"

require "test/unit"
require "wrong"
require "shoulda-context"

Wrong.config.color

include Infer

class Test::Unit::TestCase
  include Wrong

  def types(*klasses)
    klasses.collect { |klass| klass.kind_of?(Inferred::Types) ? Inferred::Types.new(klass) : Inferred::Types.only(klass) }.inject(:+)
  end

  def gentypes(klass)
    Inferred::Types.new Inferred::GenericType.new(klass)
  end

  def infer(src)
    Inferrer::TypeInferrer.new(src).infer
  end
end
