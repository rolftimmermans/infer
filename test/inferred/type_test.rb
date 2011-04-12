require File.expand_path("../test_helper", File.dirname(__FILE__))

class InferredTypeTest < Test::Unit::TestCase
  context "type" do
    subject { Infer::Inferred::Type.new(String) }

    should "have ancestors" do
      assert { subject.ancestors == [String, Object, BasicObject] }
    end

    should "be equal to same type" do
      assert { subject == Infer::Inferred::Type.new(String) }
    end

    should "equal same type" do
      assert { subject.eql? Infer::Inferred::Type.new(String) }
    end

    should "not equal different type" do
      deny { subject.eql? Infer::Inferred::Type.new(Object) }
    end

    should "not equal same generic type" do
      deny { subject.eql? Infer::Inferred::GenericType.new(String) }
    end

    should "inspect class" do
      assert { subject.inspect == "String" }
    end
  end

  context "generic type" do
    subject { Infer::Inferred::GenericType.new(String) }

    should "have ancestors" do
      assert { subject.ancestors == [String, Object, BasicObject] }
    end

    should "be equal to same type" do
      assert { subject == Infer::Inferred::GenericType.new(String) }
    end

    should "equal same generic type" do
      assert { subject.eql? Infer::Inferred::GenericType.new(String) }
    end

    should "not equal different generic type" do
      deny { subject.eql? Infer::Inferred::GenericType.new(Object) }
    end

    should "not equal same type" do
      deny { subject.eql? Infer::Inferred::Type.new(String) }
    end

    should "inspect class" do
      assert { subject.inspect == "kind of String" }
    end
  end

  context "type list" do
    subject { Infer::Inferred::TypeList.new(Infer::Inferred::Type.new(String)) }

    should "be equal to same type list" do
      assert { subject == Infer::Inferred::TypeList.new(Infer::Inferred::Type.new(String)) }
    end
  end
end
