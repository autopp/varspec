# Varspec

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'varspec'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install varspec

## Usage

```ruby
#!/usr/bin/env/ruby

require 'varspec'
include Varspec

def double(x)
  variable[:x].is_kind_of(Numeric)
  x * 2
end

double(21) # => 42
double("21") # => ???
```

    $ ./sample.rb
    

## Contributing

1. Fork it ( https://github.com/[my-github-username]/varspec/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
