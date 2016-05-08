require 'pathname'

# lib/import_airports.rb
class ImportAirports
  def self.import(dir, file)
    airports = {}
    dir.join(file).each_line do |line|
      airport = line.split(' ')
      unless line.strip.empty?
        airports[airport[1]] ||= []
        airports[airport[1]] << airport[0]
      end
    end
    airports
  end
end
