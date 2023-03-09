require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should be valid' do
    user = User.create(username: '',
                       email: '',
                       password: '')
    expect(user).to_not be_valid
  end

  it 'should create a new user' do
    user = User.create(username: 'user 1',
                       email: 'useremail@email.com',
                       password: 'password')
    expect(user.username).to eql('user 1')
  end
end
