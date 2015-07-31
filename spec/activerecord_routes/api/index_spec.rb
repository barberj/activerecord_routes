require 'spec_helper'

describe ActiveRecordRoutes do
  describe 'index request against Model' do
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
      it 'returns ok status' do
        request(:get, '/users')
        expect(response.status).to eq(200)
      end
      context 'with query_params' do
        it 'returns records on page' do
          request(:get, '/users', {page: 1})
          expect(json).to be_present
        end
        it 'returns empty when page exceeds record count' do
          request(:get, '/users', {page: 2})
          expect(json).to be_empty
        end
        it 'returns matching records' do
          request(:get, '/users', {id: ids})
          expect(json).to be_present
        end
        context 'filters' do
          it 'by id' do
            ids.pop
            ids << User.last.id + 100
            request(:get, '/users', {id: ids})
            expect(json.size).to eq(2)
          end
          it 'everything' do
            ids = [User.last.id + 100]
            request(:get, '/users', {id: ids})
            expect(json).to be_empty
          end
          it 'by created_after' do
            request(:get, '/users',
              {created_after: 1.year.from_now.strftime('%FT%TZ')}
            )
            expect(json).to be_empty

            request(:get, '/users',
              {created_after: 1.year.ago.strftime('%FT%TZ')}
            )
            expect(json).to be_present
          end
          it 'by updated_after' do
            request(:get, '/users',
              {updated_after: 1.year.from_now.strftime('%FT%TZ')}
            )
            expect(json).to be_empty

            request(:get, '/users',
              {updated_after: 1.year.ago.strftime('%FT%TZ')}
            )
            expect(json).to be_present
          end
        end
      end
    end
  end
end
