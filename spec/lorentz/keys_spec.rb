require 'spec_helper'

describe "keys" do
  let(:lorentz) { Lorentz.new }

  describe "#exists" do
    context "when key exists" do
      it "should return true" do
        lorentz.set("chunky", "bacon")
        lorentz.exists("chunky").should be_true
      end
    end

    context "when key doesn't exist" do
      it "should return false" do
        lorentz.exists("chunky").should be_false
      end
    end

  end

  describe "#del" do
    before do
      lorentz.set("chunky", 0)
      lorentz.set("bacon", 1)
    end
    it "should delete keys that exist" do
      lorentz.del("chunky", "bacon", "pet ham")
      lorentz.exists("chunky").should be_false
      lorentz.exists("bacon").should be_false
      lorentz.exists("pet ham").should be_false
    end

    it "should return the number of deleted keys" do
      lorentz.del("chunky", "bacon", "pet ham").should eq(2)
    end
  end
end
