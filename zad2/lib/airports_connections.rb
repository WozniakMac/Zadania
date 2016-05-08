# lib/airports_connections
class AirportsConnections
  def initialize(airports)
    @airports = airports
  end

  def generate
    # take all 2-elements connections
    @airports.values.flatten.permutation(2).each do |connection|
      yield connection
    end
    @airports.each_key do |continent|
      in_continent_connetions(continent) { |connection| yield connection }
      change_continent_connections(continent) { |connection| yield connection }
    end
  end

  private

  def in_continent_connetions(continent)
    # take all (3,4)-elements whithout changing continent
    3.upto(4).each do |elements|
      @airports[continent].permutation(elements).each do |permutation|
        yield permutation
      end
    end
  end

  def change_continent_connections(continent)
    @airports.keys.select { |c| c != continent }.each do |changed_continent|
      # take all 4-elements connections
      # whitch changing continent in first and last flight
      @airports[changed_continent].permutation(3).each do |permutation|
        @airports[continent].each do |airport|
          yield permutation + [airport]
          yield [airport] + permutation
        end
      end

      @airports[continent].permutation(2).each do |permutation|
        # take all 3-elements connections
        # whitch changing continent in first and last flight
        @airports[changed_continent].each do |airport|
          yield permutation + [airport]
          yield [airport] + permutation
        end
        # take all 4-elements connections
        # whitch changing continent in middle flight
        @airports[changed_continent].permutation(2).each do |change_permutation|
          yield permutation + change_permutation
        end
      end
    end
  end
end
