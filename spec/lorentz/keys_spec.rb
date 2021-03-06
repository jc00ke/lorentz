require 'spec_helper'

#EXPIRE
#EXPIREAT
#MOVE
#OBJECT
#PERSIST
#SORT
#TTL
#TYPE

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

  describe "#keys" do
    before do
      lorentz.set("chunky", 0)
      lorentz.set("bacon", 1)
      lorentz.set("chunked", 2)
      lorentz.set("thunk", 3)
    end

    it "should match 'unk'" do
      keys = lorentz.keys('*unk*')
      keys.should have(3).items
      %w(chunky chunked thunk).each do |k|
        keys.should include(k)
      end
    end

    it "should return all" do
      keys = lorentz.keys('*')
      keys.should have(4).items
      %w(chunky chunked thunk bacon).each do |k|
        keys.should include(k)
      end
    end
  end

  describe "#rename" do

    context "when key exists" do

      before do
        lorentz.set("chunky", "bacon")
      end

      context "and newkey exists" do
        before do
          lorentz.set("yummy", "snacks")
        end

        it "should overwrite newkey" do
          lorentz.rename("chunky", "yummy")
          lorentz.get("yummy").should == "bacon"
        end
      end

      context "and newkey doesn't exist" do
        it "it should set new key" do
          lorentz.rename("chunky", "yummy")
          lorentz.get("yummy").should == "bacon"
        end
      end

      context "and newkey is the same" do
        it "should raise a LorentzException" do
          expect do
            lorentz.rename("chunky", "chunky")
          end.to raise_error(LorentzException)
        end
      end

    end

    context "when key doesn't exist" do
      it "should raise a LorentzException" do
        expect do
          lorentz.rename("chunky", "yummy")
        end.to raise_error(LorentzException)
      end

    end
  end

  describe "renamenx" do
    
    context "when key exists" do

      before do
        lorentz.set("chunky", "bacon")
      end

      context "and newkey exists" do
        it "should return 0" do
          lorentz.set("funky", "cold medina")
          lorentz.renamenx("chunky", "funky").should be_zero
        end
      end
       
      context "and newkey doesn't exist" do
        it "should return 1" do
          lorentz.renamenx("chunky", "funky").should eq(1)
        end
      end

      context "and newkey is the same" do
        it "should raise a LorentzException" do
          expect do
            lorentz.rename("chunky", "chunky")
          end.to raise_error(LorentzException)
        end
      end
    end

    context "when key doesn't exist" do
      it "should raise a LorentzException" do
        expect do
          lorentz.renamenx("chunky", "yummy")
        end.to raise_error(LorentzException)
      end

    end
  end

  describe "randomkey" do
    context "database with some keys" do
      before do
        1.upto(1000){ |i| lorentz.set(i, i) }
      end

      it "should return a random key" do
        (1..100).to_a.inject([]) do |memo, i|
          memo << lorentz.randomkey
        end.uniq.should have_at_least(90).keys
      end
    end

    context "empty database" do
      before do
        # delete in case... paranoid much?
        ::Maglev::PERSISTENT_ROOT.delete(:lorentz_db_100)
      end
      it "should return nil" do
        l = Lorentz.new(:db => :lorentz_db_100)  
        l.randomkey.should be_nil
      end
    end
  end
end
