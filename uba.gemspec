
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uba/version'

Gem::Specification.new do |spec|
  spec.name          = 'uba'
  spec.version       = Uba::VERSION
  spec.authors       = ['Simon Lacroix']
  spec.email         = ['simon@miaou.be']

  spec.summary       = 'Simple CQRS/Event sourcing gem'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'rschema'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
end
