class User < ActiveRecord::Base
  route_settings :index, :show, :destroy, :create
end
