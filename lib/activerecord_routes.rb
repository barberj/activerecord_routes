require 'activerecord_routes/version'
require 'active_record'
require 'active_support'
require 'activerecord_routes/concerns/routing'
require 'grape'
require 'grape-kaminari'

module ActiveRecordRoutes
  autoload :Builder, 'activerecord_routes/builder'
  autoload :Routing, 'activerecord_routes/concerns/routing'

  API = Class.new Grape::API
  ActiveRecord::Base.send(:include, ActiveRecordRoutes::Routing)
end
