require 'spec_helper'
describe ActiveRecordRoutes do
  describe 'create request against Model' do
    context 'when valid record' do
      it 'creates' do
        request(:post, '/users', {email: 'user@test.com'})
        expect(json).to be_present
      end
    end
    context 'when invalid record' do
      it 'raises duplicate error'
      it 'raises required error'
    end
  end
end
