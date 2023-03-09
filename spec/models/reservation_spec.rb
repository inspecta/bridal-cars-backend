require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it 'should be valid' do
    reservation = Reservation.create(city: '',
                                     duration: '',
                                     reservation_date: '')
    expect(reservation).to_not be_valid
  end

  it 'should create a new reservation' do
    car = Car.create(name: 'Car Name', model: 'M1', price: 0, description: 'very good car')
    user = User.create(username: 'user 1', email: 'useremail@email.com', password: 'password')
    reservation = Reservation.create(city: 'The City',
                                     duration: 2,
                                     reservation_date: '03-04-2023',
                                     user_id: user.id,
                                     car_id: car.id)
    expect(reservation.city).to eql('The City')
  end
end
