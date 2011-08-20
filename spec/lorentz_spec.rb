require 'spec_helper'

describe Lorentz do
  context "default" do
    its(:db) { should be_empty }
    its(:db) { should be_a(Hash) }
  end
end
