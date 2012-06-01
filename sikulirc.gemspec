# -*- encoding: utf-8 -*-
require 'rake'

$:.push File.expand_path("../lib", __FILE__)
require "sikulirc/version"

Gem::Specification.new do |gem|
  gem.authors       = ["Enix Shen"]
  gem.email         = ["enix12enix@hotmail.com"]
  gem.description   = %q{Allows you to call sikuli remote server.}
  gem.summary       = %q{Ruby wrapped for sikuli remote server client api}
  gem.homepage      = ""

  # gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = FileList['lib/**/*', 'bin/*', '[A-Z]*', 'test/**/*'].to_a
  # gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "sikulirc"
  gem.require_paths = ["lib"]
  gem.version       = Sikulirc::VERSION
end
