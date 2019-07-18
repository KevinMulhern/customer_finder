module CustomerFinder
  class Customers
    def self.all
      JSON.parse(File.read('people.json')).map do |customer|
        Customer.new(customer)
      end
    end
  end
end
