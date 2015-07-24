require "activerecord_routes/version"
require "active_record"
require "active_support"
require "activerecord_routes/concerns/routing"
require "grape"

module ActiveRecordRoutes
  ActiveRecord::Base.include ActiveRecordRoutes::Routing
end
