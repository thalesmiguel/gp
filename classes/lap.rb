require 'time'
require_relative '../modules/time_module'
include TimeModule

class Lap
  def initialize(lap_params)
    set_lap(lap_params)
  end

  attr_reader :happened_at, :pilot_id, :pilot_name, :lap, :lap_time, :lap_average_speed

  private

  def set_lap(params)
    @happened_at = Time.parse(params[:happened_at])
    @pilot_id = params[:pilot_id].to_i
    @pilot_name = params[:pilot_name]
    @lap = params[:lap].to_i
    @lap_time = time_to_seconds(params[:lap_time])
    @lap_average_speed = params[:lap_average_speed].to_f
  end
end
