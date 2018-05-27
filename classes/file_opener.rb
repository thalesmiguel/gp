class FileOpener
  def initialize(file_path)
    @file_path = file_path
  end

  attr_reader :file_path

  def get_race_from_file
    lap_data = []

    File.open(file_path, 'r') do |file|
      file.each_line.with_index do |line, index|
        next if index == 0 # Skip the first line
        data = line.split()
        lap_params = {
          happened_at: data[0],
          pilot_id: data[1],
          pilot_name: data[3],
          lap: data[4],
          lap_time: data[5],
          lap_average_speed: data[6]
        }
        lap = Lap.new(lap_params)

        lap_data << lap
      end
    end
    return Race.new(lap_data)
  end
end
