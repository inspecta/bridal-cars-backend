require 'rails_helper'

RSpec.describe Car, type: :model do
  it 'should be valid' do
    car = Car.create(name: '',
    model: '',
    price: 0,
    description: '',)
    expect(car).to_not be_valid
  end

  it 'should create a new car' do
    car = Car.create(name: 'Car Name',
    model: 'M1',
    price: 0,
    description: 'very good car',)
    expect(car.name).to eql('Car Name')
  end
end