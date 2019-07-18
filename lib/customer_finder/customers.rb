module CustomerFinder
  class Customers
    def initialize;end

    def self.all
      new.all
    end

    def all
      JSON.parse(File.read(customer_file_path)).map do |customer|
        Customer.new(customer)
      end
    end

    private

    def customer_file_path
      Configuration.instance.customer_file_path
    end
  end
end
