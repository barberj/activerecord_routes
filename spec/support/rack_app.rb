module RackApp
  def app
    ActiveRecordRoutes::API
  end

  def request(method, body={}, headers={})
    @response = send(method, body, headers)
  end

  def response
    @response
  end

  def json
    JSON.parse(response.body)
  end
end
