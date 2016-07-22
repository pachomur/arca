source 'https://rubygems.org'

#manejo de vistas bootstrap
group :assets do
#Stile manage of the site

  if RUBY_PLATFORM.include? "linux"
    gem 'therubyracer'
    gem 'gravatar_image_tag'
  else
    gem "tzinfo-data"
  end
  #gem 'less-rails' #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
  # Use CoffeeScript for .js.coffee assets and views
  #gem 'coffee-rails', '~> 4.0.0'

end

#Administracion
gem 'devise'

#Time line
gem 'timeline_setter', '~> 0.3.2'

#Presentacion, vista con bootstrap
gem 'twitter-bootstrap-rails'
gem 'bootstrap_form'
#manejo de fuentes
gem 'font-awesome-rails'
#Manejo de paginacion

gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem 'diff-lcs'
#rails generate bootstrap:install static
#

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'

  #rails generate rspec:install
end

#Manejo de imagenes
gem 'paperclip', '~> 3.5.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.3'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring','~> 1.3.6',        group: :development

#Ancestry for Category associtations
gem 'ancestry'

#Para Heroku
gem 'rails_12factor', group: :production

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'coffee-script-source', '1.8.0'

