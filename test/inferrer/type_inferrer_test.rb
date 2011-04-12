require File.expand_path("../test_helper", File.dirname(__FILE__))

class TypeInferrerTest < Test::Unit::TestCase
  def list(*klasses)
    klasses.collect { |klass| Infer::Inferred::Type.create(klass) }.inject(:+)
  end

  def infer(src)
    Infer::Inferrer::TypeInferrer.new(src).infer
  end

  context "inferrer" do
    should "infer nil" do
      assert { infer("nil") == list(NilClass) }
    end

    should "infer fixnum" do
      assert { infer("4") == list(Fixnum) }
    end

    should "infer bignum" do
      assert { infer("12345678901234567890") == list(Bignum) }
    end

    should "infer float" do
      assert { infer("1.23") == list(Float) }
    end

    should "infer range" do
      assert { infer("1..10") == list(Range) }
    end

    should "infer array" do
      assert { infer("[1, 2, 3]") == list(Array) }
    end

    should "infer hash" do
      assert { infer("{ :foo => :bar, :baz => :qux }") == list(Hash) }
    end

    should "infer character" do
      assert { infer("?a") == list(String) }
    end

    should "infer string" do
      assert { infer("'foobar'") == list(String) }
    end
  end
end
