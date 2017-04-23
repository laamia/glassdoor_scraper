require_relative './lib/glassdoor_scraper/version'

Gem::Specification.new do |s|
  s.name        = 'glassdoor_scraper'
  s.version     = GlassdoorJobs::VERSION
  s.date        = '2017-04-23'
  s.summary     = "Software Engineering Jobs on Glassdoor"
  s.description = "Provides details on software jobs available in NYC"
  s.authors     = ["Laamia Islam"]
  s.email       = 'laamia.islam@gmail.com'
  s.files       = ["lib/glassdoor_scraper.rb", "lib/glassdoor_scraper/cli.rb", "lib/glassdoor_scraper/scraper.rb", "lib/glassdoor_scraper/job.rb", "bin/console"]
  s.homepage    = 'http://rubygems.org/gems/glassdoor_scraper'
  s.license     = 'MIT'
  s.executables << 'glassdoor'

  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", ">= 0"
  s.add_development_dependency "nokogiri", ">= 0"
  s.add_development_dependency "pry", ">= 0"
end
