class ActiveRecordRoutes::Builder
  def self.build_api(klass, actions, default_page_size: 50, max_page_size: 250)
    api_name = "#{klass}API"
    return if Module.const_defined?(api_name)

    new_api = Object.const_set(api_name, Class.new(Grape::API))

    new_api.class_eval do
      include Grape::Kaminari

      def self.active_record
        name.chomp('API').constantize
      end

      format :json

      paginate(
        per_page: default_page_size,
        max_per_page: max_page_size,
        offset: false
      )

      helpers do
        def active_record
          options[:for].active_record
        end

        def query_params
          params.
            slice(*active_record.column_names - %w(created_at updated_at)).
            to_h
        end

        def updated_after
          Time.new(1970, 1, 1, 0, 0, 0, 0)
        end

        def created_after
          Time.new(1970, 1, 1, 0, 0, 0, 0)
        end
      end

      resource klass.name.downcase.pluralize do
        if actions.include?(:index)
          get do
            paginate(
              klass.where(query_params).
              where('created_at > ?', created_after).
              where('updated_at > ?', updated_after)
            )
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
