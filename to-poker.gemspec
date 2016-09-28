Gem::Specification.new do |gem|
  gem.name    = 'to-poker'
  gem.version = '0.0.1'
  gem.date    = Date.today.to_s

  gem.summary = "Toronto Ruby Brigade Poker Project"
  gem.description = gem.summary

  gem.authors  = ['Gregor MacDougall']
  gem.email    = 'gmacdougall@gmail.com'
  gem.homepage = 'http://github.com/gmacdougall/to-poker'

  gem.add_dependency('rake')
  gem.add_development_dependency('rspec', [">= 3.5.0"])

  # ensure the gem is built out of versioned files
  gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
end

