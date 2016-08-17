# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'site_builder/client_version'

Gem::Specification.new do |spec|
  spec.name          = "site_builder_client"
  spec.version       = SiteBuilder::CLIENT_VERSION
  spec.authors       = ["did"]
  spec.email         = ["didier@nocoffee.fr"]
  spec.summary       = %q{Ruby toolkit for working with the LocomotiveCMS SiteBuilder API}
  spec.description   = %q{Simple wrapper for the LocomotiveCMS SiteBuilder API}
  spec.homepage      = "http://www.locomotivecms.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httpclient'
  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'json'
end
