class ActiveRecordRoutes::Builder
  def self.build_api(klass, actions)
    api_name = "#{klass}API"
    return if Module.const_defined?(api_name)

    new_api = Object.const_set(api_name, Class.new(Grape::API))
    new_api.format(:json)

    new_api.resource(klass.to_s.downcase.pluralize) do
      if actions.include?(:index)
        new_api.get do
          klass.all
        end
      end
      if actions.include?(:show)
        new_api.params do
          requires :id, desc: "#{klass} id."
        end
        new_api.get :id do
          klass.find(id)
        end
      end
    end
  end
end
