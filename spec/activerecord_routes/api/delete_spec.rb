require 'spec_helper'

describe ActiveRecordRoutes do
  describe 'destroy request against Model' do
    context 'without records' do
      it 'returns 404' do
        request(:delete, '/users/1')
        expect(response.status).to eq(404)
      end
    end
    context 'with records' do
      before do
        (1..3).each do
          User.create(email: Faker::Internet.email)
        end
      end
    end
  end
end
