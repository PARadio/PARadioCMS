class Livestream::Stats

  def self.time_taken_sec (date = Time.now)
    streamitems = Streamitem.where(date: date.strftime('%Y-%m-%d')).sorted

    if streamitems.empty?
      time_taken = 0
    else
      time_taken = TimeDifference.between(Livestream::Config.start_time, streamitems.last.start_time + streamitems.last.episode.duration.seconds).in_seconds
    end

    return time_taken
  end

  def self.time_taken_obj (date = Time.now)
    streamitems = Streamitem.where(date: date.strftime('%Y-%m-%d')).sorted

    if streamitems.empty?
      time_taken_hrs = 0
    else
      time_taken_hrs = TimeDifference.between(Livestream::Config.start_time, streamitems.last.start_time + streamitems.last.episode.duration.seconds).in_hours
    end
    time_taken_min = ("0." + time_taken_hrs.to_s.split('.').last).to_f * 60
    time_taken_sec = ("0." + time_taken_sec.to_s.split('.').last).to_f * 60

    time_obj = {
      "hrs" => time_taken_hrs.to_i,
      "min" => time_taken_min.to_i,
      "sec" => time_taken_sec.to_i
    }
    return time_obj
  end

  def self.time_taken_str (date = Time.now)
    time_obj = Livestream::Stats.time_taken_obj(date)

    return time_obj['hrs'].to_s + "h " + time_obj['min'].to_s + "m " + time_obj['sec'].to_s + "s"
  end

  def self.time_available_sec (date = Time.now)
    streamitems = Streamitem.where(date: date.strftime('%Y-%m-%d')).sorted

    if streamitems.empty?
      time_available = TimeDifference.between(Livestream::Config.start_time, Livestream::Config.end_time).in_seconds
    else
      time_available = TimeDifference.between(streamitems.last.start_time + streamitems.last.episode.duration.seconds, Livestream::Config.end_time).in_seconds
    end

    return time_available
  end

  def self.time_available_obj (date = Time.now)
    streamitems = Streamitem.where(date: date.strftime('%Y-%m-%d')).sorted

    if streamitems.empty?
      time_available_hrs = TimeDifference.between(Livestream::Config.start_time, Livestream::Config.end_time).in_hours
    else
      time_available_hrs = TimeDifference.between(streamitems.last.start_time + streamitems.last.episode.duration.seconds, Livestream::Config.end_time).in_hours
    end
    time_available_min = ("0." + time_available_hrs.to_s.split('.').last).to_f * 60
    time_available_sec = ("0." + time_available_min.to_s.split('.').last).to_f * 60

    time_obj = {
      "hrs" => time_available_hrs.to_i,
      "min" => time_available_min.to_i,
      "sec" => time_available_sec.to_i
    }
    return time_obj
  end

  def self.time_available_str (date = Time.now)
    time_obj = Livestream::Stats.time_available_obj(date)

    return time_obj['hrs'].to_s + "h " + time_obj['min'].to_s + "m " + time_obj['sec'].to_s + "s"
  end

  def self.total_time_sec (date = Time.now)
    return TimeDifference.between(Livestream::Config.start_time(date), Livestream::Config.end_time(date)).in_seconds
  end

  def self.percent_taken (date = Time.now)
    return ((Livestream::Stats.time_taken_sec(date) / Livestream::Stats.total_time_sec(date)) * 100).round(2)
  end

end
