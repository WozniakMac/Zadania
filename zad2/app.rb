require 'rubygems'
require 'bundler'
require 'pathname'
require 'benchmark'
require_relative 'lib/import_airports.rb'
require_relative 'lib/airports_connections.rb'

data_dir = Pathname.new(__dir__).join('data')

airports = ImportAirports.import(data_dir, 'airports.dat')
generator = AirportsConnections.new(airports)

Benchmark.bm do |x|
  x.report { generator.generate {} }
end
