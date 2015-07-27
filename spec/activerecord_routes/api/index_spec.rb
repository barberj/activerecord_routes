require 'spec_helper'

describe ActiveRecordRoutes do
  describe 'index' do
    context 'without records' do
      it 'returns empty' do
        request(:get, '/users', {page: 1})
        expect(json).to be_empty
      end
    end
    context 'with records' do
      before do
        User.create(email: 'barber.justin@gmail.com')
      end
      it 'returns page' do
        request(:get, '/users', {page: 1})
        expect(json).to be_present
      end
      it 'returns empty page' do
        request(:get, '/users', {page: 2})
        expect(json).to be_empty
      end
    end
  end
end
