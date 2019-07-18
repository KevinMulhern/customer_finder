require 'json'
require_relative 'customer'

module CustomerFinder
  class Search
    def initialize(location:, radius:, filters:, sort:)
      @location = location
      @radius = radius
      @filters = filters
      @sort = sort
    end

    def results
      {
        'asc' => matching_customers.sort_by(&sort_field.to_sym),
        'desc' => matching_customers.sort_by(&sort_field.to_sym).reverse,
      }.fetch(sort_order)
    end

    private

    attr_reader :location, :radius, :filters, :sort

    def matching_customers
      customers.select do |customer|
        customer.within_range?(location, radius) && customer.match?(filters)
      end
    end

    def customers
      Customers.all
    end

    def sort_field
      sort.fetch(:field, 'value')
    end

    def sort_order
      sort.fetch(:order, 'desc')
    end
  end
end
