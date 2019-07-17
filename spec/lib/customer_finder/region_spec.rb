require 'spec_helper'

module CustomerFinder
  RSpec.describe Region do
    subject(:region) do
      described_class.new(latitude: 51.450167, longitude: -2.594678, radius: 100)
    end

    let(:customers_file) do
      "[{\"id\":1,\"value\":1000},{\"id\":2,\"value\":2000},{\"id\":3,\"value\":3000}]"
    end
    let(:customers) do
      [{"id"=>1, "value"=>1000}, {"id"=>2, "value"=>2000}, {"id"=>3, "value"=>3000}]
    end

    before do
      allow(File).to receive(:read).with('people.json').
        and_return(customers_file)
    end

    describe '#customers' do
      it 'returns customers' do
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
