# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'app_store_lookup/version'

Gem::Specification.new do |s|
  s.name          = "app_store_lookup"
  s.version       = AppStoreLookup::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Michal Hlaváček"]
  s.email         = ["hello@michalhlavacek.com"]

  s.summary       = "AppStoreLookup is a parser of app info from iTunes."
  s.description   = "AppStoreLookup is a parser of app info from iTunes."
  s.homepage      = "https://github.com/HlavacekMichal/app_store_lookup"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.11"
  s.add_development_dependency "rake", "~> 10.0"
end
