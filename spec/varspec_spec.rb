require 'spec_helper'

include Varspec
include Varspec::BuiltinMatcher

def twice(x)
  variable[:x].is Numeric
  x * 2
end

def sum(a)
  variable[:a].is ArrayOf[Numeric]
  variable[:a].is ArrayOf(Numeric)
  
  a.reduce(&:+)
end

def inc(x)
  variable[:x].is Maybe[Numeric]
  
  x ? x + 1 : 1
end

describe Varspec do
  it 'returns 42' do
    expect(twice(21)).to eq(42)
  end
  
  it 'returns 31' do
    expect(sum([1, 2, 4, 8, 16])).to eq(31)
  end
  
  it 'raises ValidationError' do
    expect{twice("21")}.to raise_error(ValidationError)
  end
  
  it 'raises ValidationError' do
    expect{sum(1)}.to raise_error(ValidationError)
  end
  
  it 'raises ValidationError' do
    expect{sum([1, "2", 3])}.to raise_error(ValidationError)
  end
  
  it 'returns x + 1' do
    expect(inc(100)).to eq(101)
    expect(inc(nil)).to eq(1)
    expect{inc("100")}.to raise_error(ValidationError)
    
    begin
      inc("100")
    rescue ValidationError => e
      puts e
    end
  end
end

describe Varspec do
  it 'has a version number' do
    expect(Varspec::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(true).to eq(true)
  end
end

