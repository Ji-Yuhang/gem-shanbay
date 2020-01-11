# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "shanbay/version"

Gem::Specification.new do |spec|
  spec.name = "shanbay"
  spec.version = Shanbay::VERSION
  spec.authors = ["Ji-Yuhang"]
  spec.email = ["yuhang.silence@gmail.com"]

  spec.summary = %q{an unofficial shanbay gem.  https://www.shanbay.com/}
  spec.description = %q{an unofficial shanbay gem. https://www.shanbay.com/}
  spec.homepage = "https://github.com/Ji-Yuhang/gem-shanbay"
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    #spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "em-http-request", "~> 1.1"
  spec.add_dependency "awesome_print", "~> 1.7"
  spec.add_dependency "rainbow", "~>3.0"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
