# Customer Finder
Find customers in a geographical area given a latitude, longitude and radius.

## Configuration
You can configure:

* The distance provider for calculating distances between a region and customers
* The customer file path for loading in customer data

By default the distance provider is a haversine algorithm and the customer file path is `people.json`.

To change the defaults:
```ruby
CustomerFinder.configure do |config|
  config.distance_provider = <your distance provider here>
  config.customer_file_path = <your customer file path here>
end
```

*note* if you want to use your own distance provider you will need to wrap it in
an object that follows the same api as the providers already present in this application.
It will need a `.between` class method and a `calculate` instance method. A wrapper around the
Geokit gem is included in this application as an example.

## Usage
To start the application:
```bash
$ bin/console
```

To output all customers within 100km of Bristol in json format:
```ruby
region = CustomerFinder::Region.new(latitude: 51.450167, longitude: -2.594678, radius: 100)
region.customers
#=>[{"email":"riddle.nixon@isodrive.me","id":"5a00487905c99b6667e5e1ea","name":"Riddle Nixon","value":3749.61},{"email":"downs.byrd@qualitern.ca","id":"5a004879a14908bc9bf24ecf","name":"Downs Byrd","value":3571.79},{"email":"melanie.buckner@fleetmix.co.uk","id":"5a00487936eb5ad19bcd5fc9","name":"Melanie Buckner","value":3320.72}...]
```

To output the average value of all customers within 200km of Bristol:
```ruby
region = CustomerFinder::Region.new(latitude: 51.450167, longitude: -2.594678, radius: 200)
region.average_customer_value #=> 2467.73
```

### filtering
The customers in a region can be filtered by any of the fields they include, for example country, email etc.

To filter customers, pass in a options hash like so:
```ruby
region = CustomerFinder::Region.new(
  latitude: 51.450167,
  longitude: -2.594678,
  radius: 200,
  options: { filters: { country: 'england' } }
)
```

### Sorting
The customers can be sorted by any of their fields, in either ascending or descending order.

To sort by ascending, pass in a options hash like so:
```ruby
region = CustomerFinder::Region.new(
  latitude: 51.450167,
  longitude: -2.594678,
  radius: 200,
  options: { sort: { field: 'value', order: 'asc' } }
)
```

To sort by descending:
```ruby
region = CustomerFinder::Region.new(
  latitude: 51.450167,
  longitude: -2.594678,
  radius: 200,
  options: { sort: { field: 'value', order: 'desc' } }
)
```

Filters and sorting can also be combined:
```ruby
region = CustomerFinder::Region.new(
  latitude: 51.450167,
  longitude: -2.594678,
  radius: 200,
  options: { sort: { field: 'value', order: 'desc' }, filters: { country: 'england' } }
)
