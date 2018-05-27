require "pathname"
require "./modules/time_module"
require "./classes/file_opener"
require "./classes/lap"
require "./classes/race"

DEFAULT_PATH_TO_FILE = "files/file.log"
puts "Default data to be loaded: (#{DEFAULT_PATH_TO_FILE})"
puts "Specify a file path with formated data or load from the default path:"

user_file_path = gets.chomp
user_file_path = nil if user_file_path.empty?

file_path = Pathname.new(user_file_path || DEFAULT_PATH_TO_FILE)
race_data = FileOpener.new(file_path).get_race_from_file

puts "Number of pilots = #{race_data.amount_of_pilots}"; puts ""
puts "=== Race results ==="; puts race_data.results; puts ""
puts "=== Best lap per pilot ==="; puts race_data.best_lap_per_pilot; puts ""
puts "=== Best race lap ==="; puts race_data.best_race_lap; puts ""
puts "=== Average speed per pilot ==="; puts race_data.average_speed_per_pilot; puts ""
puts "=== Pilot arrival after the winner ==="; puts race_data.arrival_after_winner_per_pilot; puts ""
