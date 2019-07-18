require 'spec_helper'

module CustomerFinder
  module DistanceProviders
    RSpec.describe GeokitDistance do
      subject(:geokit_distance) do
        described_class.new(origin: origin, destination: destination, unit: unit)
      end

      let(:origin) do
        instance_double(Location, latitude: 51.450167, longitude: -2.594678)
      end

      let(:destination) do
        instance_double(Location, latitude: 51.077801, longitude: -3.082931)
      end

      let(:unit) { :kms }
      let(:geokit) { instance_double(Geokit::LatLng) }

      before do
        allow(Geokit::LatLng).to receive(:new).
          with(origin.latitude, origin.longitude).and_return(geokit)

        allow(geokit).to receive(:distance_to).
          with("#{destination.latitude}, #{destination.longitude}").
            and_return(200)
      end

      describe '#calculate' do
        it 'returns the distnace between the locations in kilometers' do
          expect(geokit_distance.calculate).to eql(200)
        end
      end
    end
  end
end
