module TimeModule
  def time_to_seconds(time_str)
    return nil unless time_str
    minutes, seconds = time_str.split(":").map{|str| str.to_f}
    minutes * 60.0 + seconds
  end

  def seconds_to_time(seconds)
    return nil unless seconds
    Time.at(seconds).utc.strftime("%H:%M:%S")
  end
end
