module CustomerFinder
  class HaversineDistance
    EARTH_RADIUS_IN_MILES = 3956
    EARTH_RADIUS_IN_KILOMETERS = 6371

    def initialize(origin:, destination:, unit:)
      @origin = origin
      @destination = destination
      @unit = unit
    end

    def self.between(origin:, destination:, unit: :km)
      new(origin: origin, destination: destination, unit: unit).calculate
    end

    def calculate
      lat1_radians = origin.latitude * radian_per_degree
      lat2_radians = destination.latitude * radian_per_degree

      distance_lat = (destination.latitude - origin.latitude) * radian_per_degree
      distance_lng = (destination.longitude - origin.longitude) * radian_per_degree

      a = Math.sin(distance_lat / 2) ** 2 +
          Math.cos(lat1_radians) *
          Math.cos(lat2_radians) *
          Math.sin(distance_lng / 2) ** 2

      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
      earth_radius.fetch(unit) * c
    end

    private

    attr_reader :origin, :destination, :unit

    def radian_per_degree
      Math::PI / 180.0
    end

    def earth_radius
      {
        miles: EARTH_RADIUS_IN_MILES,
        km: EARTH_RADIUS_IN_KILOMETERS,
        feet: EARTH_RADIUS_IN_MILES * 5282,
        meters: EARTH_RADIUS_IN_KILOMETERS * 1000,
      }
    end
  end
end
