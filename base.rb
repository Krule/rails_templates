# Base template

# Empty gemfile
run 'cat /dev/null > Gemfile'

# Build new one
add_source 'https://rubygems.org'

gem 'bcrypt', '~> 3.1.7'
gem 'coffee-rails', '~> 4.0.0'
gem 'jbuilder', '~> 2.0'
gem 'puma'
gem 'rails', '4.1.6'
gem 'sass-rails', '~> 4.0.3'
gem 'slim-rails'
gem 'sqlite3'
gem 'squeel'
gem 'uglifier', '>= 1.3.0'

gem_group :development do
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'spring'
  gem 'spring-commands-rspec'
end

gem_group :development, :test do
  gem 'did_you_mean'
  gem 'debugger'
  gem 'jazz_hands'
  gem 'rspec-rails'
end

gem_group :test do
  gem 'fabrication'
  gem 'shoulda-matchers', require: false
  gem 'webmock'
end

generate :controller, 'app', 'index'
route %q(root to: 'app#index')


environment %q(
  config.after_initialize do
    Bullet.enable = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
    Bullet.add_footer = false
  end
), env: 'development'

file '.bowerrc', <<-JSON
{
  "directory": "vendor/assets/components"
}
JSON

file '.bower.json', <<-JSON
{
  "name": "#{ARGV[1].capitalize} Base",
  "private": true,
  "dependencies": {
    "jquery":         "~> 2.1",
    "jquery-ujs":     "~> 1.0.1"
  }
}
JSON

run 'bower install'

git :init
git add: '-A'
git commit: %Q( -m 'A long time ago in a galaxy far, far away...')
