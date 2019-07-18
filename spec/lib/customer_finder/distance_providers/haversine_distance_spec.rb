require 'spec_helper'

module CustomerFinder
  module DistanceProviders
    RSpec.describe HaversineDistance do
      subject(:haversine_distance) do
        described_class.new(origin: origin, destination: destination, unit: unit)
      end

      let(:origin) do
        instance_double(Location, latitude: 51.450167, longitude: -2.594678)
      end

      let(:destination) do
        instance_double(Location, latitude: 51.077801, longitude: -3.082931)
      end

      let(:unit) { :km }

      describe '#calculate' do
        it 'returns the distance between the locations in kilometers' do
          expect(haversine_distance.calculate).to eql(53.55791130847151)
        end

        context 'when unit is "miles"' do
          let(:unit) { :miles }

          it 'returns the distance between the locations in miles' do
            expect(haversine_distance.calculate).to eql(33.25617597493538)
          end
        end

        context 'when the unit is "feet"' do
          let(:unit) { :feet }

          it 'returns the distance between the locations in feet' do
            expect(haversine_distance.calculate).to eql(175659.12149960868)
          end
        end

        context 'when the unit is "meters"' do
          let(:unit) { :meters }

          it 'returns the distance between the locations in meters' do
            expect(haversine_distance.calculate).to eql(53557.91130847151)
          end
        end
      end
    end
  end
end
