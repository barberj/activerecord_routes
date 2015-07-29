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
        (1..3).each do
          User.create(email: Faker::Internet.email)
        end
      end
      let(:ids) { User.all.map(&:id) }
      it 'returns page' do
        request(:get, '/users', {page: 1})
        expect(json).to be_present
      end
      it 'returns page when query has matches' do
        request(:get, '/users', {id: ids})
        expect(json).to be_present
      end
      it 'returns matching' do
        ids.pop
        ids << User.last.id + 100
        request(:get, '/users', {id: ids})
        expect(json.size).to eq(2)
      end
      it 'returns empty page' do
        request(:get, '/users', {page: 2})
        expect(json).to be_empty
      end
      it 'returns empty when query has no matches' do
        ids = [User.last.id + 100]
        request(:get, '/users', {id: ids})
        expect(json).to be_empty
      end
    end
  end
end
