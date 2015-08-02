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
          api_class.active_record
        end

        def api_class
          options[:for]
        end

        def query_params
          params.
            slice(*active_record.column_names - %w(created_at updated_at)).
            to_h
        end

        def filter_since(time_after)
          Time.parse(
            params.fetch(
              time_after,
              Time.new(1970, 1, 1, 0, 0, 0, 0).
                strftime('%FT%TZ')
            )
          )
        end

        def updated_after
          filter_since('updated_after')
        end

        def created_after
          filter_since('created_after')
        end
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        message = e.message.scan(/Couldn't find \w+/).first
        error!(message, 404)
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

        if actions.include?(:destroy)
          params do
            requires :id, desc: "#{klass} id."
          end
          delete ':id' do
            klass.find(params[:id]).destroy
          end

          delete do
            klass.where(query_params)
          end
        end
      end
    end

    ActiveRecordRoutes::API.mount(new_api)
  end
end
