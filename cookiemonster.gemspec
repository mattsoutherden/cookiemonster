# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cookiemonster/version"

Gem::Specification.new do |s|
  s.name        = "cookiemonster"
  s.version     = CookieMonster::VERSION
  s.authors     = ["Matt Southerden"]
  s.email       = ["matt@localbubble.com"]
  s.homepage    = "http://github.com/mattsoutherden/cookiemonster"
  s.summary     = %q{Let CookieMonster munch your cookies}
  s.description = %q{A library for working with Set-Cookie data in Ruby}

  s.rubyforge_project = "cookiemonster"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "minitest"

  # s.add_runtime_dependency "rest-client"
end
