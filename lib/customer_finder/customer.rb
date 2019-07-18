module CustomerFinder
  class Customer < Dry::Struct
    transform_keys(&:to_sym)

    attribute :country, Types::String
    attribute :email, Types::String
    attribute :id, Types::String
    attribute :location, CustomerFinder::Location
    attribute :value, Types::Coercible::Float

    attribute :name do
      transform_keys(&:to_sym)

      attribute :first, Types::String
      attribute :last, Types::String
    end

    def as_hash
      {
        email: email,
        id: id,
        name: full_name,
        value: value,
      }
    end

    def match?(filters)
      filters.all? do |filter, filter_value|
        self.send(filter.to_sym) == filter_value
      end
    end

    def within_range?(region_location, radius)
      location.distance_to(region_location) <= radius
    end

    private

    def full_name
      "#{name.first} #{name.last}"
    end
  end
end
