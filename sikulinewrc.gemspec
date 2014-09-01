# -*- encoding: utf-8 -*-
require 'rake'

$:.push File.expand_path("../lib", __FILE__)
require "sikulinewrc/version"

Gem::Specification.new do |gem|
  gem.authors = ["powerkx"]
  gem.email = ["powerkx@gmail.com"]
  gem.description = %q{Allows you to call sikuli remote server.}
  gem.summary = %q{Ruby wrapped for sikuli remote server client api}
  gem.homepage = "http://github.com/powerkx/sikulinewrc"

  gem.files = FileList['lib/**/*', 'bin/*', '[A-Z]*', 'test/**/*'].to_a
  gem.name = "sikulinewrc"
  gem.require_paths = ["lib"]
  gem.version = Sikulinewrc::VERSION
end
