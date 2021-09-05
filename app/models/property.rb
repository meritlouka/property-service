class Property < ActiveRecord::Base
    scope :by_property_type, -> (property_type) { where(:property_type =>  property_type) }
    scope :by_offer_type, -> (offer_type) { where(:offer_type =>  offer_type) }
    scope :in_certian_redius, -> (lat,lng,redius) { where("point(lat,lng) <@> point(?,?) < ?", lat, lng, redius) }
end