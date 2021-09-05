class PropertySerializer < ActiveModel::Serializer
  attributes :house_number, :street,:city, :zip_code, :city, :lat, :lng, :price
end