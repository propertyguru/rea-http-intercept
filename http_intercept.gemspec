# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'http_intercept/version'

Gem::Specification.new do |spec|
  spec.name          = 'http_intercept'
  spec.version       = HttpIntercept::VERSION
  spec.authors       = ['Aidan Steele']
  spec.email         = ['aidan.steele@rea-group.com']

  spec.summary       = %q{Like Rack middleware, but for outgoing HTTP calls}

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'geminabox-client'
end
