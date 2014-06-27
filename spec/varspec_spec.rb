require 'spec_helper'

include Varspec

def twice(x)
  variable[:x].is_kind_of Numeric
  x * 2
end

describe Varspec do
  it 'returns 42' do
    expect(twice(21)).to eq(42)
  end
  
  it 'raise error' do
    expect{twice("21")}.to raise_error(ValidationError)
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

