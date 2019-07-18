require 'spec_helper'

module CustomerFinder
  RSpec.describe Search do
    subject(:search) do
      described_class.new(
        location: location,
        radius: radius,
        filters: filters,
        sort: sort
      )
    end

    let(:location) { instance_double(Location, latitude: 51.450167, longitude: -2.594678 ) }
    let(:radius) { 100 }
    let(:filters) { { country: 'england' } }
    let(:sort) { {} }
    let(:customers) do
      [
        customer_one,
        customer_two,
        customer_three,
      ]
    end

    let(:customer_one) do
      instance_double(
        Customer,
        within_range?: true,
        match?: false,
        value: 2000,
      )
    end

    let(:customer_two) do
      instance_double(
        Customer,
        within_range?: true,
        match?: true,
        value: 2000,
      )
    end

    let(:customer_three) do
      instance_double(
        Customer,
        within_range?: true,
        match?: true,
        value: 3000,
      )
    end

    before do
      allow(Customers).to receive(:all).and_return(customers)
    end

    describe '#results' do
      it 'returns customer search results' do
        expect(search.results).to eql([customer_three, customer_two])
      end

      context 'when accending sort order is selected' do
        let(:sort) { { order: 'asc' } }

        it 'returns sorted by ascending customer search results' do
          expect(search.results).to eql([customer_two, customer_three])
        end
      end
    end
  end
end
