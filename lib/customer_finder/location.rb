module CustomerFinder
  class Location < Dry::Struct
    transform_keys(&:to_sym)

    attribute :latitude, Types::Coercible::Float
    attribute :longitude, Types::Coercible::Float

    def distance_to(other_location)
      HaversineDistance.between(origin: self, destination: other_location)
    end
  end
end
