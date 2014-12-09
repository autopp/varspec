module Varspec
  module BuiltinMatcher
  end
end

# load each builtin matcher
require 'varspec/builtin_matcher/array_of'
require 'varspec/builtin_matcher/hash_of'
require 'varspec/builtin_matcher/boolean'
require 'varspec/builtin_matcher/eq'
require 'varspec/builtin_matcher/not'
require 'varspec/builtin_matcher/and'
require 'varspec/builtin_matcher/or'
require 'varspec/builtin_matcher/maybe'
require 'varspec/builtin_matcher/truthy'
require 'varspec/builtin_matcher/falsey'
require 'varspec/builtin_matcher/any'
require 'varspec/builtin_matcher/none'
require 'varspec/builtin_matcher/respond_to'
require 'varspec/builtin_matcher/tuple_of'

# Define module function corresponding each builtin matcher
module Varspec
  module BuiltinMatcher
    self.constants(false).select { |c| self.const_get(c, false) < Matcher }.each do |c|
      code = <<-EOS
        def #{c}(*args)
          #{c}[*args]
        end
        
        module_function #{c.inspect}
      EOS
      eval(code) # rubocop:disable Lint/Eval
    end
  end
end
