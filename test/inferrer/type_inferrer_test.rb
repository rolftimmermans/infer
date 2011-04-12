require File.expand_path("../test_helper", File.dirname(__FILE__))

class TypeInferrerTest < Test::Unit::TestCase
  context "inferrer" do
    should "infer nil" do
      assert { infer("nil") == Inferred::Types.only(NilClass) }
    end

    should "infer true" do
      assert { infer("true") == Inferred::Types.only(TrueClass) }
    end

    should "infer false" do
      assert { infer("false") == Inferred::Types.only(FalseClass) }
    end

    should "infer fixnum" do
      assert { infer("4") == Inferred::Types.only(Fixnum) }
    end

    should "infer bignum" do
      assert { infer("12345678901234567890") == Inferred::Types.only(Bignum) }
    end

    should "infer float" do
      assert { infer("1.23") == Inferred::Types.only(Float) }
    end

    should "infer range" do
      assert { infer("1..10") == Inferred::Types.only(Range) }
    end

    should "infer array" do
      assert { infer("[1, 2, 3]") == Inferred::Types.only(Array) }
    end

    should "infer hash" do
      assert { infer("{ :foo => :bar, :baz => :qux }") == Inferred::Types.only(Hash) }
    end

    should "infer character" do
      assert { infer("?a") == Inferred::Types.only(String) }
    end

    should "infer string" do
      assert { infer("'foobar'") == Inferred::Types.only(String) }
    end

    context "binary and operator" do
      should "infer true and true" do
        assert { infer("true and true") == Inferred::Types.only(TrueClass) }
      end

      should "infer true and false" do
        assert { infer("true and false") == Inferred::Types.only(FalseClass) }
      end

      should "infer false and false" do
        assert { infer("false and false") == Inferred::Types.only(FalseClass) }
      end
    end

    context "binary or operator" do
      should "infer true or true" do
        assert { infer("true or true") == Inferred::Types.only(TrueClass) }
      end

      should "infer true or false" do
        assert { infer("true or false") == Inferred::Types.only(TrueClass) }
      end

      should "infer false or false" do
        assert { infer("false or false") == Inferred::Types.only(FalseClass) }
      end
    end
  end
end
