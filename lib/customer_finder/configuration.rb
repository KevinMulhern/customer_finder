require 'singleton'

module CustomerFinder
  class Configuration
    include Singleton

    attr_accessor :distance_provider
    attr_accessor :customer_file_path
  end
end
