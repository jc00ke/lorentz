require 'spec_helper'

describe Lorentz::Glob do
  let(:wild)  { Lorentz::Glob.compile('Fairy?ake*') }
  let(:wildi) { Lorentz::Glob.compile('Fairy?ake*\?', true) }
  let(:wildc) { Lorentz::Glob.compile('Fairy[cf]ake[!\\]]') }

  it 'should match correct strings' do
    wild.should match('Fairycake')
    wild.should match('Fairyfakes')
    wild.should match('Fairylake is a cool place')
  end

  it 'should not match incorrect strings' do
    wild.should_not match('Dairycake')
    wild.should_not match('Fairysteakes')
    wild.should_not match('fairycake')
  end

  it 'should match case insensitive' do
    wildi.should match('FairyCake?')
    wildi.should match('fairyfakes?')
    wildi.should match('FairyLake IS A COOL Place?')
  end

  it 'should know about character classes' do
    wildc.should match('Fairycake!')
    wildc.should match('Fairyfake]')
  end
end
