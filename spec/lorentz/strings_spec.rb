require 'spec_helper'

describe "strings" do
  let(:lorentz) { Lorentz.new }

  describe "#set" do
    it "should set the key to the value" do
      lorentz.set("chunky", 'bacon').should == "OK"
      lorentz.db["chunky"].should eq("bacon")
    end
  end

  describe "#setnx" do
    context "when key exists" do
      xit "should not set" do

      end
    end

    context "when key doesn't exist" do
      xit "should set" do
        
      end
    end
  end

  describe "#get" do
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

  describe "#append" do
    context "when key exists" do
      context "and is a string" do
        xit "should tack value on to end of string" do

        end
         xit "should return length of value" do

         end
      end
    end
  end
end
