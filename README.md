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

To output all customers within 100km of Bristol and live in England in json format:
```ruby
region = CustomerFinder::Region.new(
  latitude: 51.450167,
  longitude: -2.594678,
  radius: 100,
  options: { filters: { country: 'england' } }
)

region.customers
#=>[{"email":"riddle.nixon@isodrive.me","id":"5a00487905c99b6667e5e1ea","name":"Riddle Nixon","value":3749.61},{"email":"downs.byrd@qualitern.ca","id":"5a004879a14908bc9bf24ecf","name":"Downs Byrd","value":3571.79},{"email":"melanie.buckner@fleetmix.co.uk","id":"5a00487936eb5ad19bcd5fc9","name":"Melanie Buckner","value":3320.72},{"email":"mcneil.turner@amtap.me","id":"5a00487a7aaf72ecd5f1ecc9","name":"Mcneil Turner","value":3119.17},{"email":"rosalinda.stone@polarium.ca","id":"5a00487a89269d9719c6ae47","name":"Rosalinda Stone","value":2839.15},{"email":"chaney.alexander@opportech.biz","id":"5a00487a6671b037eaae5826","name":"Chaney Alexander","value":2643.05},{"email":"ruiz.preston@tingles.me","id":"5a004879a8c50420eb989be1","name":"Ruiz Preston","value":2542.41},{"email":"pierce.arnold@datagene.org","id":"5a004879ee4c0501b5921e6c","name":"Pierce Arnold","value":2462.96},{"email":"burgess.sanchez@datacator.com","id":"5a00487923e2c2428ad973b4","name":"Burgess Sanchez","value":2289.4},{"email":"karyn.hess@enaut.org","id":"5a00487898a445517663540a","name":"Karyn Hess","value":2287.04},{"email":"barnett.mayo@tersanki.biz","id":"5a004879a9fd958062eea032","name":"Barnett Mayo","value":2098.47},{"email":"corrine.lawson@ronelon.biz","id":"5a004879c5f159630e71ae5c","name":"Corrine Lawson","value":2008.06},{"email":"bettye.martinez@remold.info","id":"5a00487a9679119a4f68e5b1","name":"Bettye Martinez","value":1636.23},{"email":"thompson.smith@gadtron.com","id":"5a00487af2b33d13456b5d06","name":"Thompson Smith","value":1546.7},{"email":"hurley.guthrie@combogen.net","id":"5a004879fa59d6bff23af485","name":"Hurley Guthrie","value":1417.33},{"email":"palmer.hernandez@inquala.com","id":"5a004879b2e834ed2d48f501","name":"Palmer Hernandez","value":1004.05}]
```

To output the average value of all customers within 200km of Bristol:
```ruby
region = CustomerFinder::Region.new(latitude: 51.450167, longitude: -2.594678, radius: 200)
region.average_customer_value #=> 2467.73
```

### Filtering (optionable)
The customers in a region can be filtered by any of the fields they include, for example country, email etc.

To filter customers, pass in a options hash like so:
```ruby
region = CustomerFinder::Region.new(
  latitude: 51.450167,
  longitude: -2.594678,
  radius: 100,
  options: { filters: { country: 'england' } }
)
```

### Sorting (optionable)
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
