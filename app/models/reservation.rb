class Reservation < ApplicationRecord
   validates :city, :duration, :reservation_date, presence: true
end
