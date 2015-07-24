module ActiveRecordRoutes::Routing
  extend ActiveSupport::Concern

  module ClassMethods
    def routes
      @routes ||= []
    end

    def route_settings(*actions, settings: {})
      actions.each do |action|
        routes << action
      end
    end
  end
end
