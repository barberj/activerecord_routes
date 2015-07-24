$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'activerecord_routes'

# tells AR what db file to use
 ActiveRecord::Base.establish_connection(
   :adapter => 'sqlite3',
   :database => 'activerecord_routes.db'
)

require 'support/migrations'
require 'support/models'

RSpec.configure do |config|
  config.before(:suite) do
    Migrations.migrate(:up)
  end

  config.after(:suite) do
    Migrations.migrate(:down)
  end
end
