require "rails_helper"

RSpec.describe Property, type: :model do
  describe ".by_property_type" do
    it "includes apartment property" do
      apartment_property = FactoryBot.create(:property, property_type: "apartment")
      sfh_property = FactoryBot.create(:property, property_type: "single_family_house")
      properties = Property.by_property_type("apartment")
      expect(properties).to include(apartment_property)
      expect(properties).not_to include(sfh_property)
    end

    it "includes single_family_house property" do
      apartment_property = FactoryBot.create(:property, property_type: "apartment")
      sfh_property = FactoryBot.create(:property, property_type: "single_family_house")
      properties = Property.by_property_type("single_family_house")
      expect(properties).to include(sfh_property)
      expect(properties).not_to include(apartment_property)
    end

    it "not includes null" do
      apartment_property = FactoryBot.create(:property, property_type: "apartment")
      properties = Property.by_property_type(nil)
      expect(properties).not_to include(apartment_property)
    end
  end

  describe ".by_offer_type" do
    it "includes sell property" do
      sell_property = FactoryBot.create(:property, offer_type: "sell")
      rent_property = FactoryBot.create(:property, offer_type: "rent")
      properties = Property.by_offer_type("sell")
      expect(properties).to include(sell_property)
      expect(properties).not_to include(rent_property)
    end

    it "includes rent property" do
      rent_property = FactoryBot.create(:property, offer_type: "rent")
      sell_property = FactoryBot.create(:property, offer_type: "sell")
      properties = Property.by_offer_type("rent")
      expect(properties).to include(rent_property)
      expect(properties).not_to include(sell_property)
    end

    it "not includes null" do
      rent_property = FactoryBot.create(:property, offer_type: "rent")
      properties = Property.by_offer_type(nil)
      expect(properties).not_to include(rent_property)
    end
  end

  describe ".in_certian_redius" do
    it "includes in redius below given" do
      in_area_property = FactoryBot.create(:property, lat: "52.5342963", lng: "13.4236807")
      out_area_property = FactoryBot.create(:property, lat: "52.5942963", lng: "13.4936807")
      properties = Property.in_certian_redius("52.5442963", "13.4336807", "5")
      expect(properties).to include(in_area_property)
      expect(properties).not_to include(out_area_property)
    end
  end

  describe ".nearest_first" do
    it "gets the near property first" do
      near_area_property = FactoryBot.create(:property, lat: "52.5342963", lng: "13.4236807")
      far_area_property = FactoryBot.create(:property, lat: "52.5942963", lng: "13.4936807")
      properties = Property.nearest_first("52.5442963", "13.4336807")
      expect(properties.first).to eq(near_area_property)
      expect(properties.second).to eq(far_area_property)
    end
  end

end