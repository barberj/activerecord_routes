require 'spec_helper'

describe ActiveRecordRoutes do
  describe 'index' do
    context 'with records' do
      it 'returns records on page' do
        response = get('/users', { page: 1 }, {})
        users = JSON.parse(response.body)
        expect(users.count).to eq 1
      end
    end
  end
end
