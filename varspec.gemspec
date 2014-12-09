# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'varspec/version'

Gem::Specification.new do |spec|
  spec.name          = 'varspec'
  spec.version       = Varspec::VERSION
  spec.authors       = ['autopp']
  spec.email         = ['autopp@gmail.com']
  spec.summary       = 'RSpec and contract.ruby inspired variable validator'
  spec.description   = 'RSpec and contract.ruby inspired variable validator'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'yard'
end
