module CustomerFinder
  class Region
    def initialize(latitude:, longitude:, radius:, options: {})
      @latitude = latitude
      @longitude = longitude
      @radius = radius
      @options = options
    end

    def customers
      JSON.generate(customer_search.results.map(&:as_hash))
    end

    def average_customer_value
      (customer_values.reduce(&:+).to_f / customer_search.results.size).round(2)
    end

    private

    attr_reader :latitude, :longitude, :radius, :options

    def customer_values
      customer_search.results.map(&:value)
    end

    def customer_search
      @customer_search ||= Search.new(
        location: location,
        radius: radius,
        filters: filters,
        sort: sort
      )
    end

    def filters
      options.fetch(:filters, {})
    end

    def sort
      options.fetch(:sort, {})
    end

    def location
      Location.new(latitude: latitude, longitude: longitude)
    end
  end
end
