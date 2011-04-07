# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ogle/version"

Gem::Specification.new do |s|
  s.name        = "ogle"
  s.version     = Ogle::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kevin Bringard"]
  s.email       = ["kbringard@attinteractive.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby interface for OpenStack Glance}
  s.description = %q{Exposes the API for OpenStack Glance. Go ahead and ogle, it's so much more than a glance.}

  s.rubyforge_project = "ogle"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "hugs", "~> 2.5.1"
  s.add_dependency "multipart-post", "~> 1.0.1"
  s.add_dependency "nokogiri", "~> 1.4.4"
  s.add_dependency "minitest"

  s.add_development_dependency "rake"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
  s.add_development_dependency "minitest"
end
