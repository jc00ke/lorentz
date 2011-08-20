require 'spec_helper'

describe "strings" do
  let(:lorentz) { Lorentz.new }

  describe "set" do
    it "should set the key to the value" do
      lorentz.set("chunky", 'bacon').should == "OK"
      lorentz.db["chunky"].should eq("bacon")
    end
  end

  describe "get" do
    context "when key exists" do
      it "should return the value" do
        lorentz.set("chunky", "bacon")
        lorentz.get("chunky").should == "bacon"
      end
    end
    it "should return nil if key doesn't exist" do
      lorentz.get("chunky").should be_nil
    end

  end
end
