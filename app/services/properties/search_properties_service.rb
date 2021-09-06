module Properties
  class SearchPropertiesService < ApplicationService
    include ActiveModel::Validations
    include ActiveModel::Callbacks
    attr_reader :property_type, :marketing_type, :lat, :lng, :page, :limit
    DISTANCE_APPLICABLE = 5


    validates :property_type, inclusion: {in: ["apartment", "single_family_house"], message: "Must be apartment or single_family_house"}
    validates :marketing_type, inclusion: {in: ["sell", "rent"], message: "Must be sell or rent"}
    validates_format_of :lat, :with => /\A\d{0,11}\.\d{0,8}\Z/, :message => "must contain up to 11 percision and up to 8 scale, seperated by a dot"
    validates_format_of :lng, :with => /\A\d{0,11}\.\d{0,8}\Z/, :message => "must contain up to 11 percision and up to 8 scale, seperated by a dot"
    validates_numericality_of :page, :greater_than_or_equal_to => 1 , allow_nil: true
    validates_numericality_of :limit, :greater_than_or_equal_to => 1, allow_nil: true

    define_model_callbacks :initialize, only: [:after]
    after_initialize :validate

    def initialize(property_type, marketing_type, lat, lng, page = nil , limit = nil)
      run_callbacks :initialize do
        @property_type = property_type
        @marketing_type = marketing_type
        @lat = lat
        @lng = lng
        @page = page
        @limit = limit
      end
    end

    def validate
      if !valid?
        raise InvalidInputParamsError.new(errors.to_hash), 'Invalid input params'
      end
    end

    def call
      properties = Property
                    .select(:house_number, :street,:city, :zip_code, :city, :lat, :lng, :price)
                    .by_property_type(@property_type)
                    .by_offer_type(@marketing_type)
                    .in_certian_redius_km(@lat, @lng, DISTANCE_APPLICABLE)
                    .nearest_first(@lat, @lng)

      if(limit.present? && @page.present?)
        properties = properties.limit(@limit).offset(@limit * (@page.to_i - 1))
      end

      raise NoDataError, 'No data for given location' unless properties.present?
      return properties
    end
  end
end