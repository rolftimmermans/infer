require File.expand_path("../test_helper", File.dirname(__FILE__))

class InferredTypesTest < Test::Unit::TestCase
  context "string type" do
    subject { Inferred::Types.only(String) }

    should "be equal to same type" do
      assert { subject == Inferred::Types.only(String) }
    end

    should "not equal different type" do
      deny { subject == Inferred::Types.only(Object) }
    end

    should "not equal same generic type" do
      deny { subject == Inferred::Types.any(String) }
    end

    should "be true" do
      assert { subject.true? == true }
    end

    should "not be false" do
      deny { subject.false? == true }
    end

    should "not be unknown" do
      deny { subject.unknown? == true }
    end

    should "concatenate with other type list" do
      concat = subject + Inferred::Types.only(Fixnum)
      assert { concat == Inferred::Types.only(String) + Inferred::Types.only(Fixnum) }
    end

    should "concatenate with other type list of generic types" do
      concat = subject + Inferred::Types.any(Integer)
      assert { concat == Inferred::Types.only(String) + Inferred::Types.any(Integer) }
    end

    should "concatenate with other type list of same generic types" do
      concat = subject + Inferred::Types.any(String)
      assert { concat == Inferred::Types.any(String) }
    end

    should "concatenate with other type list with anything" do
      concat = subject + Inferred::Types.anything
      assert { concat == Inferred::Types.anything }
    end

    should "not modify original types on concatenation" do
      concat = subject + Inferred::Types.only(Fixnum)
      assert { subject == Inferred::Types.only(String) }
    end

    should "inspect" do
      assert { subject.inspect == "{String}" }
    end
  end

  context "generic string type" do
    subject { Inferred::Types.any(String) }

    should "be equal to same type" do
      assert { subject == Inferred::Types.any(String) }
    end

    should "not equal different generic type" do
      deny { subject == Inferred::Types.any(Object) }
    end

    should "not equal same type" do
      deny { subject == Inferred::Types.only(String) }
    end

    should "be true" do
      assert { subject.true? }
    end

    should "not be false" do
      deny { subject.false? }
    end

    should "not be unknown" do
      deny { subject.unknown? }
    end

    should "concatenate with other type list of generic supertype" do
      concat = subject + Inferred::Types.any(Object)
      assert { concat == Inferred::Types.any(Object) }
    end

    should "inspect" do
      assert { subject.inspect == "{<any String>}" }
    end
  end

  context "anything" do
    subject { Inferred::Types.anything }

    should "not be true" do
      deny { subject.true? == true }
    end

    should "not be false" do
      deny { subject.false? == true }
    end

    should "be unknown" do
      assert { subject.unknown? == true }
    end

    should "inspect" do
      assert { subject.inspect == "{<anything>}" }
    end
  end

  context "false type" do
    subject { Inferred::Types.only(FalseClass) }

    should "not be true" do
      deny { subject.true? == true }
    end

    should "be false" do
      assert { subject.false? == true }
    end

    should "not be unknown" do
      deny { subject.unknown? == true }
    end
  end

  context "type list with multiple types" do
    subject { Inferred::Types.only(String) + Inferred::Types.any(Integer) + Inferred::Types.only(Range) }

    should "concatenate with other type list of generic supertype" do
      concat = subject + Inferred::Types.any(Object)
      assert { concat == Inferred::Types.any(Object) }
    end

    should "inspect" do
      assert { subject.inspect == "{String, Range, <any Integer>}" }
    end
  end
end
