require 'spec_helper'

describe ActiveRecordRoutes do
  describe 'show request against Model' do
    context 'without records' do
      context 'with id' do
        it 'returns not found (404)' do
          request(:get, '/users/1')
          expect(response.status).to eq(404)
        end
        it 'returns error message' do
          request(:get, '/users/1')
          expect(json['error']).to eq("Couldn't find User")
        end
      end
    end
    context 'with records' do
      before do
        (1..3).each do
          User.create(email: Faker::Internet.email)
        end
      end
      context 'with id' do
        it 'returns' do
          request(:get, "/users/#{User.first.id}")
          expect(json['id']).to eq 1
        end
        it 'returns ok (200)' do
          request(:get, "/users/#{User.first.id}")
          expect(response.status).to eq 200
        end
      end
    end
  end
end
