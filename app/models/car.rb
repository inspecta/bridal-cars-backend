class Car < ApplicationRecord
  # validations
  validates :name, presence: true, length: { minimum: 2, too_short: 'Car name must more than 2 characters' }
  validates :model, presence: true
  validates :price, presence: true
  validates :description, presence: true,
                          length: { minimum: 5, too_short: 'Car description must more than 5 characters' }
end
