Gem::Specification.new do |s|
  s.name          = 'wordsearch'
  s.version       = '0.0.1'
  s.authors       = ["Mike Kolich"]
  s.email         = 'mikekolich@gmail.com'
  s.description   = "Wordsearch kata for Pillar."
  s.summary       = "wordsearch"

  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard-rspec"
end