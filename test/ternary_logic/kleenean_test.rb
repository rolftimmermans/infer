require File.expand_path("../test_helper", File.dirname(__FILE__))

class TernaryLogicKleeneanTest < Test::Unit::TestCase
  def truthy
    Infer::TernaryLogic::TRUE
  end

  def falsy
    Infer::TernaryLogic::FALSE
  end

  def unknown
    Infer::TernaryLogic::UNKNOWN
  end

  context "truthy object" do
    subject { truthy }

    should "be truthy" do
      assert { subject.true? }
    end

    should "not be falsy" do
      deny { subject.false? }
    end

    should "not be unknown" do
      deny { subject.unknown? }
    end
  end

  context "falsy object" do
    subject { falsy }

    should "be truthy" do
      deny { subject.true? }
    end

    should "not be falsy" do
      assert { subject.false? }
    end

    should "not be unknown" do
      deny { subject.unknown? }
    end
  end

  context "unknown object" do
    subject { unknown }

    should "be truthy" do
      deny { subject.true? }
    end

    should "not be falsy" do
      deny { subject.false? }
    end

    should "not be unknown" do
      assert { subject.unknown? }
    end
  end

  context "truthy vs truthy" do
    should "be truthy for a and b" do
      assert { truthy & truthy == truthy }
    end

    should "be truthy for a or b" do
      assert { truthy | truthy == truthy }
    end
  end

  context "truthy vs unknown" do
    should "be unknown for a and b" do
      assert { truthy & unknown == unknown }
    end

    should "be truthy for a or b" do
      assert { truthy | unknown == truthy }
    end
  end

  context "truthy vs falsy" do
    should "be falsy for a and b" do
      assert { truthy & falsy == falsy }
    end

    should "be truthy for a or b" do
      assert { truthy | falsy == truthy }
    end
  end

  context "unknown vs truthy" do
    should "be unknown for a and b" do
      assert { unknown & truthy == unknown }
    end

    should "be truthy for a or b" do
      assert { unknown | truthy == truthy }
    end
  end

  context "unknown vs unknown" do
    should "be unknown for a and b" do
      assert { unknown & unknown == unknown }
    end

    should "be unknown for a or b" do
      assert { unknown | unknown == unknown }
    end
  end

  context "unknown vs falsy" do
    should "be falsy for a and b" do
      assert { unknown & falsy == falsy }
    end

    should "be unknown for a or b" do
      assert { unknown | falsy == unknown }
    end
  end

  context "falsy vs truthy" do
    should "be falsy for a and b" do
      assert { falsy & truthy == falsy }
    end

    should "be truthy for a or b" do
      assert { falsy | truthy == truthy }
    end
  end

  context "falsy vs unknown" do
    should "be falsy for a and b" do
      assert { falsy & unknown == falsy }
    end

    should "be unknown for a or b" do
      assert { falsy | unknown == unknown }
    end
  end

  context "falsy vs falsy" do
    should "be falsy for a and b" do
      assert { falsy & falsy == falsy }
    end

    should "be falsy for a or b" do
      assert { falsy | falsy == falsy }
    end
  end
end
