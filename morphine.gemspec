# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'morphine/version'

Gem::Specification.new do |s|
  s.name        = 'morphine'
  s.version     = Morphine::VERSION
  s.authors     = ['Brandon Keepers']
  s.email       = ['brandon@opensoul.org']
  s.homepage    = ''
  s.summary     = %q{A lightweight dependency injection framework for Ruby}
  s.description = %q{Morphine is a lightweight dependency injection framework for Ruby. It uses a simple Ruby DSL to ease the pain of wiring your dependencies together.}

  s.rubyforge_project = 'morphine'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec', '~>2.0'
end
