module CustomerFinder
  class Region
    def initialize(latitude:, longitude:, radius:)
      @latitude = latitude
      @longitude = longitude
      @radius = radius
    end

    def customers
      []
    end

    def average_customer_value
      0
    end
  end
end
