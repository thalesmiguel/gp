require "test/unit"
require_relative "../../classes/lap"

class LapSpec < Test::Unit::TestCase
  def test_initialize
    lap_params = {
      :happened_at=>"23:49:12.667",
      :pilot_id=>"023",
      :pilot_name=>"M.WEBBER",
      :lap=>"1",
      :lap_time=>"1:04.414",
      :lap_average_speed=>"43,202"
    }

    lap = Lap.new(lap_params)
    assert_equal(lap.happened_at, Time.parse("23:49:12.667"))
    assert_equal(lap.pilot_id, "023".to_i)
    assert_equal(lap.pilot_name, "M.WEBBER")
    assert_equal(lap.lap, "1".to_i)
    assert_equal(lap.lap_time, time_to_seconds("1:04.414"))
    assert_equal(lap.lap_average_speed, "43,202".to_f)
  end
end
