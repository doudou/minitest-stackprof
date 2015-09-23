# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minitest/stackprof/version'

Gem::Specification.new do |spec|
    spec.name          = "minitest-stackprof"
    spec.version       = Minitest::Stackprof::VERSION
    spec.authors       = ["Sylvain Joyeux"]
    spec.email         = ["sylvain.joyeux@m4x.org"]

    spec.summary       = "minitest plugin to profile your tests with stackprof"
    spec.homepage      = "https://github.com/doudou/minitest-stackprof"
    spec.license       = "MIT"

    spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    spec.bindir        = "exe"
    spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
    spec.require_paths = ["lib"]

    spec.add_runtime_dependency "minitest", ">= 5.0"
    spec.add_runtime_dependency "stackprof", ">= 0.2.7"
    spec.add_development_dependency "bundler", "~> 1.10"
    spec.add_development_dependency "rake", "~> 10.0"
end
