require 'spec_helper'

module CustomerFinder
  RSpec.describe Location do
    subject(:location) do
      described_class.new(latitude: '51.077801', longitude: '-3.082931')
    end

    describe '#latitude' do
      it 'returns the locations latitude' do
        expect(location.latitude).to eql(51.077801)
      end
    end

    describe '#longitude' do
      it 'returns the locations longitude' do
        expect(location.longitude).to eql(-3.082931)
      end
    end
  end
end
