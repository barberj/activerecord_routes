module ActiveRecordRoutes::Routing
  extend ActiveSupport::Concern

  module ClassMethods
    def routes
      @routes ||= []
    end

    def route_settings(*actions, settings: {})
      routes.concat(actions)
      ActiveRecordRoutes::Builder.build_api(self, actions, **settings)
    end
  end
end
