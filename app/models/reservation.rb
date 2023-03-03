class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :city, :duration, :reservation_date, presence: true
end
