$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'activerecord_routes'
require 'rack/test'
require 'database_cleaner'
require 'faker'

# tells AR what db file to use
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'activerecord_routes.db'
)

Dir["./spec/support/**/*.rb"].sort.each { |f| require f}

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RackApp

  DatabaseCleaner.strategy = :truncation

  config.before(:suite) do
    Migrations.migrate(:up)
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

  config.after(:suite) do
    Migrations.migrate(:down)
  end
end
