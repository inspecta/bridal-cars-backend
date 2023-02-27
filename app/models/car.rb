class Car < ApplicationRecord
  # validations
  validates :name, presence: true, length: { minimum: 2, msg: 'Car name must more than 2 characters' }
  validates :model, presence: true

  # Associations
end
