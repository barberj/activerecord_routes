require 'spec_helper'

describe ActiveRecordRoutes do
  describe 'destroy request against Model' do
    context 'without records' do
      context 'with id' do
        it 'returns not found (404)' do
          request(:delete, '/users/1')
          expect(response.status).to eq(404)
        end
        it 'returns error message' do
          request(:delete, '/users/1')
          expect(json['error']).to eq("Couldn't find User")
        end
      end
      context 'with filter' do
        it 'returns ok (200)' do
          request(:delete, '/users', {id: 1})
          expect(response.status).to eq(200)
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
        it 'deletes' do
          expect { request(:delete, "/users/#{User.first.id}") }.
            to change{ User.count }.by(-1)
        end
        it 'returns deleted' do
          request(:delete, "/users/#{User.first.id}")
          expect(json['id']).to eq 1
        end
        it 'returns ok (200)' do
          request(:delete, "/users/#{User.first.id}")
          expect(response.status).to eq 200
        end
      end
      context 'with filter' do
        it 'deletes' do
          id = User.first.id
          expect { request(:delete, '/users', {id: id}) }.
            to change{ User.count }.by(-1)
        end
        it 'returns deleted' do
          id = User.first.id
          request(:delete, '/users', {id: id})
          expect(json.first['id']).to eq(id)
        end
      end
    end
  end
end
