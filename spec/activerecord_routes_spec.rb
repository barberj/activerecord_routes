require 'spec_helper'

describe ActiveRecordRoutes do
  it 'has a version number' do
    expect(ActiveRecordRoutes::VERSION).not_to be nil
  end

  it 'Specs are hooked up to database' do
    User.create(email: 'barber.justin@gmail.com')

    expect(User.count).to eq 1
  end

  it 'can list models' do
    models = ActiveRecord::Base.subclasses.
      collect(&:name).sort

    expect(models).to include 'User'
  end

  it 'includes Routing concern on ActiveRecord::Base' do
    expect(ActiveRecord::Base.ancestors).to include(ActiveRecordRoutes::Routing)
  end
end
