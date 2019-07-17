require 'spec_helper'

module CustomerFinder
  RSpec.describe Region do
    subject(:region) do
      described_class.new(latitude: 51.450167, longitude: -2.594678, radius: 100)
    end

    let(:customers_data) { File.read('spec/fixtures/mock_customers.json') }
    let(:customers) do
      "[{\"email\":\"karyn.hess@enaut.org\",\"id\":\"5a00487898a445517663540a\",\"name\":\"Karyn Hess\",\"value\":1000.0},{\"email\":\"riddle.nixon@isodrive.me\",\"id\":\"5a00487905c99b6667e5e1ea\",\"name\":\"Riddle Nixon\",\"value\":2000.0}]"
    end

    before do
      allow(File).to receive(:read).with('people.json').
        and_return(customers_data)
    end

    describe '#customers' do
      it 'returns customers within region' do
        expect(region.customers).to eql(customers)
      end
    end

    describe '#average_customer_value' do
      it 'returns average customer value for the region' do
        expect(region.average_customer_value).to eql(1500.0)
      end
    end
  end
end
