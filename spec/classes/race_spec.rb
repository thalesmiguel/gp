require "test/unit"
require_relative "../../classes/lap"
require_relative "../../classes/race"

LAP_DATA = [Lap.new({
  :happened_at=>"23:49:12.667",
  :pilot_id=>"023",
  :pilot_name=>"M.WEBBER",
  :lap=>"4",
  :lap_time=>"1:04.414",
  :lap_average_speed=>"43,202"
})]

def create_race
  Race.new(LAP_DATA)
end

class RaceSpec < Test::Unit::TestCase
  def test_initialize
    race = create_race
    assert_equal(race.laps, LAP_DATA)
    assert_equal(race.laps.count, 1)
  end

  def test_results
    race = create_race
    assert_match("M.WEBBER", race.results.to_s)
  end

  def test_amount_of_pilots
    race = create_race
    assert_equal(race.amount_of_pilots, 1)
  end

  def test_best_lap_per_pilot
    race = create_race
    assert_match("M.WEBBER", race.best_lap_per_pilot.to_s)
  end

  def test_best_race_lap
    race = create_race
    assert_match("M.WEBBER", race.best_race_lap.to_s)
  end

  def test_average_speed_per_pilot
    race = create_race
    assert_match("M.WEBBER", race.average_speed_per_pilot.to_s)
  end

  def test_arrival_after_winner_per_pilot
    race = create_race
    assert_match("M.WEBBER", race.arrival_after_winner_per_pilot.to_s)
  end
end
