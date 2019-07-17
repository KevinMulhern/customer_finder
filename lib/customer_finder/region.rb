module CustomerFinder
  class Region
    def initialize(latitude:, longitude:, radius:)
      @latitude = latitude
      @longitude = longitude
      @radius = radius
    end

    def customers
      JSON.generate(all_customers.map(&:as_json))
    end

    def average_customer_value
      customer_values.reduce(0, &:+).to_f / all_customers.size
    end

    private

    def customer_values
      all_customers.map(&:value)
    end

    def all_customers
      @all_customers ||= JSON.parse(File.read('people.json')).map do |customer|
        Customer.new(customer)
      end
    end
  end
end
