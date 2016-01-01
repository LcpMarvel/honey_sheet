# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'honey_sheet/version'

Gem::Specification.new do |spec|
  spec.name          = 'honey_sheet'
  spec.version       = HoneySheet::VERSION
  spec.authors       = ['lcp']
  spec.email         = ['lcpmarvel@gmail.com']

  spec.summary       = ' Export Excel or CSV easily. '
  spec.description   = ' Export Excel or CSV easily. '
  spec.homepage      = 'https://github.com/LcpMarvel/honey_sheet'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
                       .reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pry'

  spec.add_runtime_dependency 'activesupport'
end
