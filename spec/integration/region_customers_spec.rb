require 'spec_helper'

RSpec.describe 'Region Customers' do

  let(:region) do
    CustomerFinder::Region.new(
      latitude: 51.450167,
      longitude: -2.594678,
      radius: 100
    )
  end

  before do
    CustomerFinder::Configuration.instance.customer_file_path = 'people.json'
  end

  it 'returns customers 100km from bristol' do
    expect(JSON.parse(region.customers).size).to eql(20)
  end

  context 'when filtering by country' do
    let(:region) do
      CustomerFinder::Region.new(
        latitude: 51.450167,
        longitude: -2.594678,
        radius: 100,
        options: { filters: { country: 'england' } }
      )
    end

    it 'returns customers 100km from bristol and from England' do
      expect(JSON.parse(region.customers).size).to eql(16)
    end
  end
end
