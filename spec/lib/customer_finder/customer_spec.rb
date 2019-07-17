require 'spec_helper'

module CustomerFinder
  RSpec.describe Customer do
    subject(:customer) { described_class.new(customer_data) }

    let(:customer_data) do
      {
        country: 'england',
        email: 'johndoe@gmail.com',
        id: '5a00487898a445517663540a',
        name: { 'first' => 'John', 'last' => 'Doe' },
        value: '2500.0',
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

    describe '#full_name' do
      it 'returns the customers full name' do
        expect(customer.full_name).to eql('John Doe')
      end
    end
  end
end
