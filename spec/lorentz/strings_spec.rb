require 'spec_helper'

#DECR
#DECRBY
#GETBIT
#GETRANGE
#GETSET
#INCR
#INCRBY
#MGET
#MSET
#MSETNX
#SETBIT
#SETEX
#SETNX
#SETRANGE

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
        before do
          lorentz.set("chunky", "bacon")
        end
        it "should tack value on to end of string" do
          lorentz.append("chunky", " is yummy")
          lorentz.get("chunky").should == "bacon is yummy"
        end
         it "should return length of value" do
          lorentz.append("chunky", " is yummy").should eq("bacon is yummy".length)
         end
      end

      context "and is not a string" do
        before do
          lorentz.set("chunky", 1)
        end

        it "should raise an error" do
          expect do
            lorentz.append("chunky", "bacon")
          end.to raise_error(LorentzException)
        end
      end
    end

    context "when key doesn't exist" do
      it "should return 'OK'" do
        lorentz.append("chunky", "bacon").should == "OK"
      end
      it "should set the key to be an empty string" do
        lorentz.append("chunky", "bacon")
        lorentz.get("chunky").should be_empty
      end
    end
  end

  describe "#strlen" do
    context "when key exists" do
      before do
        lorentz.set("chunky", "baconz")
        lorentz.set("foo", ["bar"])
      end
      it "should return length of string value" do
        lorentz.strlen("chunky").should eq(6)
      end

      it "should raise an error if value isn't a string" do
        expect do
          lorentz.strlen("foo")
        end.to raise_error(LorentzException)
      end
    end

    context "when key doesn't exist" do
      it "should return 0" do
        lorentz.strlen("chunky").should eq(0)
      end
    end
  end
end
