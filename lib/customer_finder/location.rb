module CustomerFinder
  class Location < Dry::Struct::Value
    transform_keys(&:to_sym)

    attribute :latitude, Types::Coercible::Float
    attribute :longitude, Types::Coercible::Float
  end
end
