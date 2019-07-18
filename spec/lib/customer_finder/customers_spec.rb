require 'spec_helper'

module CustomerFinder
  RSpec.describe Customers do
    describe '.all' do
      subject(:customers) { described_class.all }

      let(:customers_data) { File.read('spec/fixtures/mock_customers.json') }

      before do
        allow(File).to receive(:read).with('people.json').
          and_return(customers_data)
      end

      it 'returns all customers' do
        expect(customers).to all(be_an_instance_of(Customer))
      end
    end
  end
end
