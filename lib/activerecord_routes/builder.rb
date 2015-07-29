class ActiveRecordRoutes::Builder
  def self.build_api(klass, actions, default_page_size: 50, max_page_size: 250)
    api_name = "#{klass}API"
    return if Module.const_defined?(api_name)

    new_api = Object.const_set(api_name, Class.new(Grape::API))

    new_api.class_eval do
      include Grape::Kaminari

      format :json

      paginate per_page: default_page_size, max_per_page: max_page_size, offset: false

      resource klass.to_s.downcase.pluralize do
        if actions.include?(:index)
          get do
            paginate(klass)
          end
        end

        if actions.include?(:show)
          params do
            requires :id, desc: "#{klass} id."
          end
          get ':id' do
            klass.find_by(id: params[:id])
          end
        end
      end
    end

    ActiveRecordRoutes::API.mount new_api
  end
end
