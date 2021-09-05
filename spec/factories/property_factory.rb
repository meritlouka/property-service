FactoryBot.define do
  factory :property, class: 'Property'  do
    offer_type {"sell"}
    property_type {"apartment"}
    zip_code {"12345"}
    city {"Berlin"}
    street {"Fehrbelliner Straße"}
    house_number {"3"}
    lng {"13.4236807"}
    lat {"52.5342963"}
    construction_year {"2021"}
    number_of_rooms {"3"}
    currency {"eur"}
    price {"269700.00"}
  end
end