require 'spec_helper'

module CustomerFinder
  RSpec.describe Customer do
    subject(:customer) { described_class.new(customer_data) }

    let(:customer_data) do
      {
        country: 'england',
        email: 'johndoe@gmail.com',
        id: '5a00487898a445517663540a',
        name: { first: 'John', last: 'Doe' },
        value: '2500.0',
        location: { latitude: '51.077801', longitude: '-3.082931' }
      }
    end

    describe '#country' do
      it 'returns the customers country' do
        expect(customer.country).to eql('england')
      end
    end

    describe '#email' do
      it 'returns the customers email' do
        expect(customer.email).to eql('johndoe@gmail.com')
      end
    end

    describe '#id' do
      it 'returns the customers id' do
        expect(customer.id).to eql('5a00487898a445517663540a')
      end
    end

    describe 'location' do
      it 'returns the customers location' do
        expect(customer.location).to be_an_instance_of(Location)
      end
    end

    describe '#name' do
      it 'returns the customers first name' do
        expect(customer.name.first).to eql('John')
      end

      it 'returns the customers last name' do
        expect(customer.name.last).to eql('Doe')
      end
    end

    describe '#value' do
      it 'returns the customers id' do
        expect(customer.value).to eql(2500.0)
      end
    end

    describe '#as_hash' do
      let(:customer_hash) do
        {
          email: 'johndoe@gmail.com',
          id: '5a00487898a445517663540a',
          name: 'John Doe',
          value: 2500.0,
        }
      end

      it 'returns selected customer details in a hash' do
        expect(customer.as_hash).to eql(customer_hash)
      end
    end

    describe '#full_name' do
      it 'returns the customers full name' do
        expect(customer.full_name).to eql('John Doe')
      end
    end

    describe '#within_range?' do
      let(:region_location) { instance_double(Location) }
      let(:radius) { 200 }
      let(:distance) { 100 }

      before do
        allow(customer.location).to receive(:distance_to).
          with(region_location).and_return(distance)
      end

      it 'returns true' do
        expect(customer.within_range?(region_location, radius)).to be(true)
      end

      context 'when the distance is larger than the radius' do
        let(:distance) { 300 }

        it 'returns false' do
          expect(customer.within_range?(region_location, radius)).to be(false)
        end
      end
    end
  end
end
