module ActiveRecordRoutes::Routing
  extend ActiveSupport::Concern

  module ClassMethods
    def routes
      @routes ||= []
    end

    def route_settings(*actions)
      routes.concat(actions)
      ActiveRecordRoutes::Builder.build_api(self, actions)
    end
  end
end
