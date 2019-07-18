require 'geokit'

module CustomerFinder
  module DistanceProviders
    class GeokitDistance
      attr_reader :origin, :destination, :unit

      def initialize(origin:, destination:, unit:)
        @origin = origin
        @destination = destination
        @unit = unit
      end

      def self.between(origin:, destination:, unit: :kms)
        new(origin: origin, destination: destination, unit: unit).calculate
      end

      def calculate
        start_location.distance_to("#{destination.latitude}, #{destination.longitude}")
      end

      private

      def start_location
        Geokit::default_units = unit
        Geokit::LatLng.new(origin.latitude, origin.longitude)
      end
    end
  end
end
