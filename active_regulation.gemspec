# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_regulation/version'

Gem::Specification.new do |spec|
  spec.name = 'active_regulation'
  spec.version = ActiveRegulation::VERSION
  spec.authors = ['Juan Gomez']
  spec.email = ['j.gomez@drexed.com']

  spec.summary = 'Gem for commonly used record states.'
  spec.description = 'Manage the states of records by commonly used attributes.'
  spec.homepage = 'http://drexed.github.io/active_regulation'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib support]

  spec.add_runtime_dependency 'activerecord'
  spec.add_runtime_dependency 'activesupport'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'fasterer'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'rubocop'
end
