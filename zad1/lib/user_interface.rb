require_relative 'hotel.rb'
# lib/ui.rb
class UserInterface
  def self.start
    puts 'Podaj wszyskie pokoje wypisując ich pojemność po spacji:'
    rooms = gets.split(' ').map(&:to_i)
    if rooms.nil? || rooms.count == 0
      puts 'Niepoprawna lista pokoi'
      return nil
    end
    hotel = Hotel.new(rooms)
    puts 'Podaj ile masz grup gości'
    groups = gets.to_i
    groups.times do |group|
      puts "Grupa #{group}, ilość dorosłych:"
      adults = gets.to_i
      if adults.nil? || adults == 0
        puts 'Niepoprawna lista dorosłych'
        return nil
      end
      puts "Grupa #{group}, ilość dzieci:"
      kids = gets.to_i
      kids ||= 0
      begin
        hotel.add_guest(adults, kids)
      rescue
        puts 'Coś poszło nie tak'
        return nil
      end
    end
    hotel.feets
    hotel.groups_to_rooms.each do |group|
      puts "W pokoju #{group[:room]} osobowym jest grupa #{group[:id]}. "\
           "#{group[:adults]} dorosłych i #{group[:kids]} dzieci"
    end
    no_empty_groups = hotel.groups.delete_if do |group|
      group[:adults] == 0 && group[:kids] == 0
    end

    no_empty_groups.each do |group|
      puts "Nie udało się rozlokować grupy #{group[:id]}. #{group[:adults]} "\
           "dorosłych i #{group[:kids]} dzieci"
    end
  end
end
