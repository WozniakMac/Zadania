# lib/hotel.rb
class Hotel
  attr_reader :groups_to_rooms, :groups

  def initialize(rooms)
    @rooms = rooms.sort.reverse
    @groups = []
    @groups_to_rooms = []
    @empty_rooms = @rooms.length
    @max_room_size = @rooms.first
  end

  def add_guest(adults, kids)
    if ((adults + kids).to_f / adults.to_f) > @max_room_size
      raise ArgumentError, 'You dont have enough big rooms'
    end
    @groups << { adults: adults, kids: kids, id: @groups.length }
  end

  def feets
    @rooms.each do |room_size|
      group = take_group
      break if group.nil? || group[:adults] == 0
      kids = ((room_size - 1) > group[:kids]) ? group[:kids] : (room_size - 1)
      adults = 1
      in_room = { adults: adults, kids: kids, id: group[:id], room: room_size }
      if count(:adults) > @empty_rooms && kids < (room_size - adults)
        free_space = room_size - kids - adults
        adults_left = group[:adults] - in_room[:adults]
        in_room[:adults] += [(count(:adults) - @empty_rooms),
                             adults_left,
                             free_space].min
      end
      clean_group(in_room)
      @groups_to_rooms << in_room
      @empty_rooms -= 1
    end
  end

  private

  def count(type)
    @groups.inject(0) { |sum, x| sum + x[type] }
  end

  def clean_group(in_room)
    @groups[in_room[:id]][:adults] -= in_room[:adults]
    @groups[in_room[:id]][:kids] -= in_room[:kids]
  end

  def take_group
    @groups.sort do |a, b|
      if count(:adults) > @empty_rooms || count(:kids) == 0
        -a[:kids] - a[:adults] <=> -b[:kids] - b[:adults]
      else
        -a[:kids] <=> -b[:kids]
      end
    end.first
  end
end
