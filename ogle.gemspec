# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ogle/version"

Gem::Specification.new do |s|
  s.name        = "ogle"
  s.version     = Ogle::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kevin Bringard", "John Dewey"]
  s.email       = ["kbringard@attinteractive.com", "john@dewey.ws"]
  s.homepage    = %q{http://github.com/kevinbringard/ogle}
  s.summary     = %q{Ruby interface for OpenStack Glance}
  s.description = %q{Exposes the API for OpenStack Glance. Go ahead and ogle, it's so much more than a glance.}

  s.rubyforge_project = "ogle"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "hugs", "~> 2.7.0"

  s.add_development_dependency "rake", "0.8.7"
  s.add_development_dependency "vcr", "1.5.0"
  s.add_development_dependency "webmock"
  s.add_development_dependency "minitest"
end
