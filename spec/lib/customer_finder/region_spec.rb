require 'spec_helper'

module CustomerFinder
  RSpec.describe Region do
    subject(:region) do
      described_class.new(latitude: 51.450167, longitude: -2.594678, radius: 100)
    end

    describe '#customers' do
      it 'returns customers' do
        expect(region.customers).to eql([])
      end
    end

    describe '#average_customer_value' do
      it 'returns average customer value for the region' do
        expect(region.average_customer_value).to eql(0)
      end
    end
  end
end
