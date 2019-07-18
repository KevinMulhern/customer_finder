require 'spec_helper'

module CustomerFinder
  RSpec.describe Region do
    subject(:region) do
      described_class.new(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
        options: options
      )
    end

    let(:latitude) { 51.450167 }
    let(:longitude) { -2.594678 }
    let(:radius) { 100 }
    let(:options) { { filters: filters, sort: sort } }
    let(:filters) { { country: 'england' } }
    let(:sort) { { field: 'value', order: 'asc'} }
    let(:location) { instance_double(Location) }

    let(:customer_search) do
      instance_double(Search, results: customer_search_results)
    end

    let(:customer_search_results) do
      [
        customer_one,
        customer_two,
        customer_three,
      ]
    end

    let(:customer_one) do
      instance_double(Customer, as_hash: { name: 'Joe Bloggs' }, value: 1000)
    end

    let(:customer_two) do
      instance_double(Customer, as_hash: { name: 'John Smith' }, value: 2000)
    end

    let(:customer_three) do
      instance_double(Customer, as_hash: { name: 'Bob Ross' }, value: 3000)
    end

    before do
      allow(Location).to receive(:new).
        with(latitude: latitude, longitude: longitude).
          and_return(location)

      allow(Search).to receive(:new).
        with(location: location, radius: radius, filters: filters, sort: sort).
          and_return(customer_search)
    end

    describe '#customers' do
      let(:customers) do
        "[{\"name\":\"Joe Bloggs\"},{\"name\":\"John Smith\"},{\"name\":\"Bob Ross\"}]"
      end

      it 'returns customers in region' do
        expect(region.customers).to eql(customers)
      end
    end

    describe '#average_customer_value' do
      it 'returns average customer value for the region' do
        expect(region.average_customer_value).to eql(2000.0)
      end
    end
  end
end
