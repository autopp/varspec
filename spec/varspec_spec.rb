require 'spec_helper'

include Varspec
include Varspec::BuiltinMatcher

def twice(x)
  expect_var[:x].to_be Numeric
  x * 2
end

def sum(a)
  expect_var[:a].to_be ArrayOf[Numeric]
  expect_var[:a].to_be ArrayOf(Numeric)
  
  a.reduce(&:+)
end

def inc(x)
  expect_var[:x].to_be Maybe[Numeric]
  
  x ? x + 1 : 1
end

def div_and_mod(x, y)
  [x / y, x % y]
end

class Parson
  def initialize(name, age)
    expect_var[:name].of_instance_to_be String
    expect_var[:age].of_instance_to_be Integer
  end
  
  def to_s
    "<#{@name}: #{@age}>"
  end
  
  def to_tuple
    [@name, @age]
  end
  
  def self.make(tuple)
    expect_var[:tuple].to_be TupleOf(String, Integer)
    new(*tuple)
  end
end

describe Varspec do
  it 'returns 42' do
    expect(twice(21)).to eq(42)
  end
  
  it 'returns 31' do
    expect(sum([1, 2, 4, 8, 16])).to eq(31)
  end
  
  it 'raises ValidationError' do
    expect { twice('21') }.to raise_error(ValidationError)
  end
  
  it 'raises ValidationError' do
    expect { sum(1) }.to raise_error(ValidationError)
  end
  
  it 'raises ValidationError' do
    expect { sum([1, '2', 3]) }.to raise_error(ValidationError)
  end
  
  it 'returns x + 1' do
    expect(inc(100)).to eq(101)
    expect(inc(nil)).to eq(1)
    expect { inc('100') }.to raise_error(ValidationError)
    
    begin
      inc('100')
    rescue ValidationError => e
      puts e
    end
  end
  
  it 'returns <Taro: 10>' do
    parson = Parson.new('Taro', 10)
    expect(parson.to_s).to eq('<Taro: 10>')
  end
  
  it 'raises ValidationError' do
    expect { Parson.new('Taro', 3.14) }.to raise_error(ValidationError)
  end
  
  it 'returns ["Taro", 10]' do
    parson = Parson.new('Taro', 10)
    tuple = parson.to_tuple 
    expect(tuple).to eq(['Taro', 10])
  end
  
  it 'raises ValidationError' do
    expect { Parson.make([10, 'Jiro']) }.to raise_error(ValidationError)
    expect { Parson.make(['Jiro']) }.to raise_error(ValidationError)
    expect { Parson.make(['Jiro', 10, 'child']) }.to raise_error(ValidationError)
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
