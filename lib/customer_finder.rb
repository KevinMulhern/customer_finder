$LOAD_PATH.unshift File.expand_path('../lib', File.dirname(__FILE__))

require 'json'
require 'dry-struct'

require 'customer_finder/types'
require 'customer_finder/customer'
require 'customer_finder/region'

module CustomerFinder;end
