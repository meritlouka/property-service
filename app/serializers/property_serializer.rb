class PropertySerializer < ActiveModel::Serializer
  attributes :house_number, :street, :city, :zip_code, :state , :city, :lat, :lng, :price

  def state
    object.city
  end
end