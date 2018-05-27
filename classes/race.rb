require_relative '../modules/time_module'
include TimeModule

class Race
  def initialize(lap_data)
    @laps = lap_data
  end

  attr_reader :laps

  LAST_LAP = 4

  def results
    results = []

    laps.group_by{|lap| lap.pilot_id}.each do |pilot_id, data|
      results << {
        position: get_pilot_position(pilot_id),
        pilot_id: pilot_id,
        pilot_name: data.first.pilot_name,
        completed_laps: data.count,
        total_race_time: seconds_to_time(data.sum{|lap| lap.lap_time})
      }
    end

    return results
  end

  def amount_of_pilots
    laps.group_by{|lap| lap.pilot_id}.count
  end

  def best_lap_per_pilot
    results = []

    laps.sort_by{|lap| lap.lap_time}.group_by{|lap| lap.pilot_id}.sort_by{|pilot_id| pilot_id}.each do |pilot_id, data|
      results << {
        pilot_id: pilot_id,
        pilot_name: data.first.pilot_name,
        best_lap: data.first.lap,
        best_lap_time: seconds_to_time(data.first.lap_time)
      }
    end

    return results
  end

  def best_race_lap
    results = []
    best_lap = laps.sort_by{|lap| lap.lap_time}.first

    results << {
      pilot_id: best_lap.pilot_id,
      pilot_name: best_lap.pilot_name,
      best_lap: best_lap.lap,
      best_lap_time: seconds_to_time(best_lap.lap_time)
    }

    return results
  end

  def average_speed_per_pilot
    results = []

    laps.group_by{|lap| lap.pilot_id}.sort_by{|pilot_id| pilot_id}.each do |pilot_id, data|
      results << {
        pilot_id: pilot_id,
        pilot_name: data.first.pilot_name,
        average_speed: get_average_speed(data)
      }
    end

    return results
  end

  def arrival_after_winner_per_pilot
    results = []
    race_finished_at = last_lap_data.first.happened_at

    laps.group_by{|lap| lap.pilot_id}.sort_by{|pilot_id| pilot_id}.each do |pilot_id, data|
      results << {
        pilot_id: pilot_id,
        pilot_name: data.first.pilot_name,
        time_after_winner: seconds_to_time(get_time_after_winner(race_finished_at, data))
      }
    end

    return results
  end

  private

  def get_time_after_winner(race_finished_at, data)
    pilot_finished_at = data.sort_by{|lap| lap.happened_at}.last.happened_at
    diff = pilot_finished_at - race_finished_at

    diff > 0.0 ? diff : nil
  end

  def get_average_speed(data)
    total_average_speed = data.sum{|lap| lap.lap_average_speed}
    number_of_laps = data.count

    number_of_laps != 0 ? (total_average_speed / number_of_laps) : 0
  end

  def get_pilot_position(pilot_id)
    match = last_lap_data.select{|lap| lap.pilot_id == pilot_id}.first
    return nil unless match # For pilots that do not finish the race
    last_lap_data.index(match) + 1
  end

  def last_lap_data
    laps.select{|lap| lap.lap == LAST_LAP}.sort_by{|lap| lap.happened_at}
  end
end
