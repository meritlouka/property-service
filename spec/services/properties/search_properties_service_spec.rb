require "rails_helper"
RSpec.describe Properties::SearchPropertiesService do
  context ".get_properties_in_area" do
    let!(:property) { create(:property,
                              lat: "50.5342963",
                              lng: "10.4236807",
                              offer_type: "sell",
                              property_type: "apartment")
                    }

    it "get the right property" do
      property_type = "apartment"
      marketing_type = "sell"
      lat = "50.5342963"
      lng = "10.4236807"
      properties = Properties::SearchPropertiesService.
                    call(property_type, marketing_type, lat, lng)
    end

    it "Fire No Data Exception when no match" do
      property_type = "apartment"
      marketing_type = "sell"
      lat = "100.5342963"
      lng = "10.4236807"
      expect { Properties::SearchPropertiesService.call(property_type, marketing_type, lat, lng) }
             .to raise_error(NoDataError)
    end

    it "Fire No Data Exception when no match" do
      property_type = "apartment"
      marketing_type = "rent"
      lat = "50.5342963"
      lng = "10.4236807"
      expect { Properties::SearchPropertiesService.call(property_type, marketing_type, lat, lng) }
             .to raise_error(NoDataError)
    end

    it "Fire Invalid Data Exception when invalid lng" do
      property_type = "apartment"
      marketing_type = "rent"
      lat = "50.5342963"
      lng = "Test"
      expect { Properties::SearchPropertiesService.call(property_type, marketing_type, lat, lng) }
             .to raise_error(InvalidInputParamsError)
    end

    it "Fire Invalid Data Exception when invalid lat" do
      property_type = "apartment"
      marketing_type = "rent"
      lat = "50.12123456787654123"
      lng = "Test"
      expect { Properties::SearchPropertiesService.call(property_type, marketing_type, lat, lng) }
             .to raise_error(InvalidInputParamsError)
    end

    it "Fire Invalid Data Exception when invalid property_type" do
      property_type = "city"
      marketing_type = "rent"
      lat = "50.12123456787654123"
      lng = "Test"
      expect { Properties::SearchPropertiesService.call(property_type, marketing_type, lat, lng) }
             .to raise_error(InvalidInputParamsError)
    end

    it "Fire Invalid Data Exception when invalid property_type" do
      property_type = "city"
      marketing_type = "buy"
      lat = "50.12123456787654123"
      lng = "Test"
      expect { Properties::SearchPropertiesService.call(property_type, marketing_type, lat, lng) }
             .to raise_error(InvalidInputParamsError)
    end
  end
end