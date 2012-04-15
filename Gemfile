source 'http://rubygems.org'

gem 'rails', '3.2.2'
gem "mongrel", '>= 1.2.0.pre2' 

group :production do
  gem 'pg'
end

group :development do
  gem 'mysql2'
end

gem 'cancan'
gem 'wicked_pdf'

# Active Admin
gem 'activeadmin', :git => 'https://github.com/gregbell/active_admin.git'

group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
gem 'sass-rails',   '~> 3.2.3'
gem "twitter-bootstrap-rails"
gem 'jquery-rails'
gem 'therubyracer' # JS Compiler from Chrome

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
end
