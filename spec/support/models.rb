class User < ActiveRecord::Base
  route_settings :index, :show, settings: { version: :v2 }
end
