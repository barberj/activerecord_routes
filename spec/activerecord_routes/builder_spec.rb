require 'spec_helper'

describe ActiveRecordRoutes::Builder do
  describe '.build_api' do
    context 'when API does not exist' do
      it 'creates' do
        Account = Class.new ActiveRecord::Base

        expect {
          ActiveRecordRoutes::Builder.build_api(Account, [:index])
        }.to change {
          Module.const_defined?('AccountAPI')
        }.to be_truthy
      end
    end
    context 'when API does exist' do
      it 'does not create' do
        UserAPI = Class.new
        ActiveRecordRoutes::Builder.build_api(User, :index)

        expect(UserAPI.ancestors).to_not include Grape::API
      end
    end
  end
end
