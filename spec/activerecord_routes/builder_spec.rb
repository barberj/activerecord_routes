require 'spec_helper'

describe ActiveRecordRoutes::Builder do
  describe '.build_api' do
    context 'when API does not exist' do
      it 'creates'
    end
    context 'when API does exist' do
      it 'does not create'
    end
  end
end
