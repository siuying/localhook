# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'localhook/version'

Gem::Specification.new do |spec|
  spec.name          = "localhook"
  spec.version       = Localhook::VERSION
  spec.authors       = ["Francis Chong"]
  spec.email         = ["francis@ignition.hk"]
  spec.summary       = %q{Localhook let you receive webhooks on localhost.}
  spec.description   = %q{Localhook makes it super easy to connect public webhook endpoints with development environments.}
  spec.homepage      = "https://github.com/siuying/localhook"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "claide"
  spec.add_dependency "em-http-request"
  spec.add_dependency "em-eventsource"
  spec.add_dependency "yajl-ruby"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
end
