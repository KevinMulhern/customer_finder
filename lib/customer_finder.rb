$LOAD_PATH.unshift File.expand_path('../lib', File.dirname(__FILE__))

require 'json'
require 'dry-struct'

require 'customer_finder/configuration'
require 'customer_finder/types'
require 'customer_finder/distance_providers/haversine_distance'
require 'customer_finder/distance_providers/geokit_distance'
require 'customer_finder/location'
require 'customer_finder/customers'
require 'customer_finder/customer'
require 'customer_finder/search'
require 'customer_finder/region'

module CustomerFinder
  def self.configure
    yield(Configuration.instance)
  end
end

CustomerFinder.configure do |config|
  config.distance_provider = CustomerFinder::DistanceProviders::HaversineDistance
  config.customer_file_path = 'people.json'
end
