module CustomerFinder
  class Region
    def initialize(latitude:, longitude:, radius:)
      @latitude = latitude
      @longitude = longitude
      @radius = radius
    end

    def customers
      JSON.generate(occupying_customers.map(&:as_hash))
    end

    def average_customer_value
      customer_values.reduce(0, &:+).to_f / occupying_customers.size
    end

    private

    attr_reader :latitude, :longitude, :radius

    def customer_values
      occupying_customers.map(&:value)
    end

    def occupying_customers
      all_customers.select do |customer|
        customer.within_range?(location, radius)
      end
    end

    def all_customers
      @all_customers ||= JSON.parse(File.read('people.json')).map do |customer|
        Customer.new(customer)
      end
    end

    def location
      Location.new(latitude: latitude, longitude: longitude)
    end
  end
end
