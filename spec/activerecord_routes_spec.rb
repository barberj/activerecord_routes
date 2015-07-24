require 'spec_helper'

describe ActiverecordRoutes do
  it 'has a version number' do
    expect(ActiverecordRoutes::VERSION).not_to be nil
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
end
