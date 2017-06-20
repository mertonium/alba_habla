lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alba_habla'

Gem::Specification.new do |s|
  s.name = 'alba_habla'
  s.version = AlbaHabla::VERSION
  s.executables << 'alba_habla'
  s.date = '2017-06-17'
  s.summary = 'Type something, read it back.'
  s.description = 'A simple little program that reads back what you type.'
  s.authors = %w[Mertonium]
  s.email = 'j@j10z.xyz'
  s.files = %w[README.md] + Dir['lib/**/*.rb']
  s.homepage = 'https://github.com/mertonium/alba_habla'
  s.license = 'MIT'

  s.add_development_dependency 'rspec', '~> 3.2'
  s.add_development_dependency 'rubocop', '~> 0.49'
end
