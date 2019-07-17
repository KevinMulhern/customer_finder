module CustomerFinder
  class Region
    def initialize(latitude:, longitude:, radius:)
      @latitude = latitude
      @longitude = longitude
      @radius = radius
    end

    def customers
      JSON.parse(File.read('people.json'))
    end

    def average_customer_value
      customer_values.reduce(0, &:+).to_f / customers.size
    end

    private

    def customer_values
      customers.map { |customer| customer.fetch('value') }
    end
  end
end
