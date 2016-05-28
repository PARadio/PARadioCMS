class Livestream::Engine

  def self.runStream
    require File.join(Rails.root, "vendor/cache/ruby/2.2.0/gems/ruby-shout-2.2.1/lib/shout")

    blocksize = 16384

    s = Shout.new
    s.mount = "/livestream"
    # s.charset = "UTF-8"
    # s.mount = "/utf8"
    s.host = Livestream::Config.icecast_config['hostname']
    s.port = Livestream::Config.icecast_config['port']
    s.user = "source"
    s.pass = Livestream::Config.icecast_config['authentication source-password']
    s.format = Shout::MP3
    s.description ='Pinkerton Radio Livestream'

    s.connect

    streamitems = Livestream::Engine.getToday

    while Time.now < Livestream::Config.end_time do
      streamitems.each do |streamitem|
        filename = Rails.root.join('public', streamitem.episode.mediafile.attachment_url)
        Icecast.streamFile(s, filename)
      end
    end

    s.disconnect
  end

  def self.getToday
    return Streamitem.where(date: Date.today.strftime('%Y-%m-%d')).sorted
  end

  def self.getCurrent
    # get all of todays queued episodes
    streamitems = Livestream::Engine.getToday

    # if no streams, then nothing playing
    if streamitems.empty? || streamitems.nil?
      return nil
    end

    # if only one stream, then only one option
    if streamitems.count == 1
      return streamitems.first
    end

    # if the current time is in between streams, return nil
    if Time.now < Livestream::Config.start_time
      return nil
    elsif Time.now > Livestream::Config.end_time
      return nil
    end


    # we know the episodes may have looped. lets find out how many times
        # get the time diff and divide by loop time to get number of loops already done
    loop_time=0
    streamitems.each do |item|
      loop_time+=item.episode.duration
    end
    num_loops = (TimeDifference.between(Livestream::Config.start_time, Time.now).in_seconds)/loop_time
    loop_frac = ('0.'+num_loops.to_s.split('.').last).to_f
    current_time_in_loop = loop_time*loop_frac
    puts current_time_in_loop
    puts streamitems.count
    time_into_loop=0
    streamitems.count.times do |i|
      puts i
      puts "time into loop #{time_into_loop.to_s}"
      next_time=streamitems[i].episode.duration+time_into_loop
      puts "next time into loop #{next_time.to_s}"
      if( current_time_in_loop >= time_into_loop && current_time_in_loop < next_time)
        puts("found it")
        return streamitems[i]
      end
      time_into_loop+=streamitems[i].episode.duration
    end
    puts "reached end"
    return nil
  end

end
