require "./lib/upstarter/version"

Gem::Specification.new do |spec|
  spec.name          = "upstarter"
  spec.version       = Upstarter::VERSION
  spec.authors       = ["Nando Vieira"]
  spec.email         = ["fnando.vieira@gmail.com"]
  spec.summary       = "Generate upstart configuration files"
  spec.description   = spec.summary
  spec.homepage      = "http://rubygems.org/gems/upstarter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  spec.add_dependency "thor"
  spec.add_dependency "erubis"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
