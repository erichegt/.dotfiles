application "config.generators do |g|
      g.test_framework :rspec,
        :view_specs     => false,
        :request_specs  => false,
        :routing_specs  => false,
        :helper_specs   => false
    end"
application("config.generators.stylesheets = false")
application("config.generators.javascripts = false")
application("config.generators.helper = false")


# clean up rails defaults
remove_file 'public/index.html'
remove_file 'public/images/rails.png'
run 'cp config/database.yml config/database.example'
append_file ".gitignore", "config/database.yml"

# gemfile
gem "rspec-rails", :group => [ :development, :test ]

# forcing bundle before tasks provided by external gems
run "bundle install"

# prepare databases
rake "db:create", :env => 'development'

# rspec
generate "rspec:install"
append_file ".rspec", "--format documentation"
append_file ".rspec", "\n"

# commit to git
git :init
git :add => "."
git :commit => "-am 'omg! initial commit.'"

run "rails s"
