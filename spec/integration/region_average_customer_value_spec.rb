require 'spec_helper'

RSpec.describe 'Region Average Customer Value' do
  let(:region) do
    CustomerFinder::Region.new(
      latitude: 51.450167,
      longitude: -2.594678,
      radius: 200
    )
  end

  before do
    CustomerFinder::Configuration.instance.customer_file_path = 'people.json'
  end

  it 'returns average value of customers within 200km of Bristol' do
    expect(region.average_customer_value).to eql(2467.73)
  end
end
