# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "lorentz/version"

Gem::Specification.new do |s|
  s.name        = "lorentz"
  s.version     = Lorentz.version
  s.authors     = ["Jesse Cooke"]
  s.email       = ["jesse@jc00ke.com"]
  s.homepage    = "https://github.com/jc00ke/lorentz"
  s.summary     = %q{Take one Redis, stick it on MagLev}
  s.description = %q{You know, for _why day!}
  s.licenses    = ['MIT']

  s.rubyforge_project = "lorentz"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '~> 2.6.0'
end
