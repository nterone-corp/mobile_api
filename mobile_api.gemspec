$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mobile_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mobile_api"
  s.version     = MobileApi::VERSION
  s.authors     = ["Oleg Bavaev"]
  s.email       = ["csolg7@gmail.com"]
  s.homepage    = "https://github.com/csolg/mobile_api"
  s.summary     = "Rails + Devise + DeviseTokenAuth + Pundit + Flutter"
  s.description = "Rails API with Devise, DeviseTokenAuth and Pundit for connecting Flutter."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.10"
  s.add_dependency "devise", "~> 4.7.1"
  s.add_dependency "devise_token_auth", "~> 1.1.4"
  s.add_dependency "pundit", "~> 1.1.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
