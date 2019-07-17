module CustomerFinder
  class Customer < Dry::Struct
    transform_keys(&:to_sym)

    attribute :country, Types::String
    attribute :email, Types::String
    attribute :id, Types::String
    attribute :value, Types::Coercible::Float

    attribute :name do
      transform_keys(&:to_sym)

      attribute :first, Types::String
      attribute :last, Types::String
    end

    def as_json
      {
        email: email,
        id: id,
        name: full_name,
        value: value,
      }
    end

    def full_name
      "#{name.first} #{name.last}"
    end
  end
end
