require 'rspec'
require_relative '../lib/airports_connections.rb'

describe AirportsConnections do
  describe '#generate' do
    before do
      @airports = { 'A' => ['A1', 'A2', 'A3', 'A4'],
                    'B' => ['B1', 'B2', 'B3', 'B4'] }
      @connections = []
      @generator = AirportsConnections.new(@airports)
      @generator.generate { |connection| @connections << connection }
    end
    describe 'connections' do
      it { expect(@connections).to include(['A1', 'A2', 'A3', 'A4']) }
      it { expect(@connections).to include(['B1', 'B2', 'B3', 'B4']) }
      it { expect(@connections).to include(['A1', 'A2', 'B3', 'B4']) }
      it { expect(@connections).to include(['A1', 'A2']) }
      it { expect(@connections).to include(['B1', 'A2']) }
      it { expect(@connections).to include(['A1', 'B1', 'B3', 'B4']) }
      it { expect(@connections).to include(['A1', 'A2', 'A3', 'B1']) }
      it { expect(@connections).not_to include(['A1', 'B2', 'A3', 'B1']) }
      it { expect(@connections).not_to include(['A1']) }
      it { expect(@connections).not_to include(['B3', 'B2', 'A3', 'B1']) }
    end
  end
end
