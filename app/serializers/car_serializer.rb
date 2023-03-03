class CarSerializer < ActiveModel::Serializer
  attributes :id, :name, :reserved, :model, :photo, :price, :description

end
