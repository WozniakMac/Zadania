require 'rspec'
require_relative '../lib/import_airports.rb'
require 'pathname'

describe ImportAirports do
  describe '.import' do
    before do
      data_dir = Pathname.new(__dir__).join('files')
      @airports = ImportAirports.import(data_dir, 'test_airports.dat')
    end

    describe 'airports' do
      it { expect(@airports).to be_kind_of(Hash) }
      it { expect(@airports.keys).to include('AS') }
      it { expect(@airports.keys).to include('EU') }
      it { expect(@airports['AS']).to include('BEY') }
      it { expect(@airports['EU']).to include('BTS') }
    end
  end
end
