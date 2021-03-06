# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord_routes/version'

Gem::Specification.new do |spec|
  spec.name          = 'activerecord_routes'
  spec.version       = ActiveRecordRoutes::VERSION
  spec.authors       = ['Justin Barber']
  spec.email         = ['barber.justin@gmail.com']

  spec.summary       = %q{Expose routes for ActiveRecord Models}
  spec.description   = %q{Expose REST routes for ActiveRecordModels.}
  spec.homepage      = 'https://github.com/barberj/activerecord_routes'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'temping'

  spec.add_runtime_dependency 'activerecord', '~> 4.2'
  spec.add_runtime_dependency 'grape', '~> 0.12'
  spec.add_runtime_dependency 'grape-kaminari'
end
