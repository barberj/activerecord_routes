class ActiveRecordRoutes::Builder
  def self.build_api(klass, actions, version: :v1, version_method: :path, format: :json)
    return if defined? "#{klass}API#{version}" == 'constant'
  end
end
