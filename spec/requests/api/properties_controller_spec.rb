require 'rails_helper'

describe Api::PropertyController do
  describe "#search" do

    context "missing params" do
      it "returns a correct status code and body" do
        expected_response = { "error"  => {
           "property_type" => ["Must be apartment or single_family_house"],
           "marketing_type" => ["Must be sell or rent"],
           "lat" => ["must contain up to 11 percision and up to 8 scale, seperated by a dot"],
           "lng" => ["must contain up to 11 percision and up to 8 scale, seperated by a dot"]
        } }
        get search_api_property_index_path, params: []
        expect(response.status).to eq 422
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq expected_response
      end
    end

    context "no data avaiable" do
      it "returns a correct status code" do
        params = {
           :marketing_type => "sell",
           :property_type => "apartment",
           :lat => "50.5342963",
           :lng => "10.4236807"
        }
        expected_response = { "error" => "No data for given location"}
        property_in = FactoryBot.create(:property,
                                :lat => "55.5342963",
                                :lng => "13.4236807"
                              )

        get search_api_property_index_path, params: params
        expect(response.status).to eq 200
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq expected_response
      end
    end

    context "correct status code" do
      it "returns a correct status code and body" do
        params = {
           :property_type => "apartment",
           :lat => "52.5342963",
           :lng => "13.4236807"
        }
        property_in = FactoryBot.create(:property, params.merge!(:offer_type => "sell"))

        get search_api_property_index_path, params: params.merge!(:marketing_type => "sell")
        expect(response.status).to eq 200
        expect(JSON.parse(response.body).first["lat"]).to eq(property_in.lat.to_s)
      end
    end
  end
end