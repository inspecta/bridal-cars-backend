class CarSerializer < ActiveModel::Serializer
  attributes :id :name :reserved :model :photo :price :description
  has_one :reservation
end
