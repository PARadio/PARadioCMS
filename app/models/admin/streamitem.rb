class Admin::Streamitem < ActiveRecord::Base
  belongs_to :episode #holds episode_id

  @@stream_start = Time.parse("05:00 AM")
  @@stream_end = Time.parse("11:00 PM")
  cattr_reader :stream_start
  cattr_reader :stream_end

  scope :sorted, lambda { order("position ASC") }



  scope :dank, lambda {
    puts 'dank'
    return 'dank'
  }

  def start_time
    position = read_attribute(:position)
    if position == 1
      return Admin::Streamitem.stream_start
    else
      date = read_attribute(:date)
      itemsBefore = Admin::Streamitem.where(date: date).where("position < :currentPosition", {currentPosition: position}).sorted
      time_counter = Admin::Streamitem.stream_start
      itemsBefore.each do |item|
        time_counter = time_counter + item.episode.duration.seconds;
      end
      return time_counter
    end
  end

  def self.getCurrent
    # get all of todays queued episodes
    streamitems = Admin::Streamitem.where(date: Date.today.strftime('%Y-%m-%d')).sorted

    # if no streams, then nothing playing
    if streamitems.empty? || streamitems.nil?
      return nil
    end

    # if only one stream, then only one option
    if streamitems.count == 1
      return streamitems.first
    end

    # if the current time is in between streams, return nil
    if Time.now < Admin::Streamitem.stream_start
      return nil
    elsif Time.now > Admin::Streamitem.stream_end
      return nil
    end


    # we know the episodes may have looped. lets find out how many times
        # get the time diff and divide by loop time to get number of loops already done
    loop_time=0
    streamitems.each do |item|
      loop_time+=item.episode.duration
    end
    num_loops = (TimeDifference.between(Admin::Streamitem.stream_start, Time.now).in_seconds)/loop_time
    loop_frac = ('0.'+num_loops.to_s.split('.').last).to_f
    current_time_in_loop = loop_time*loop_frac
    puts current_time_in_loop
    puts streamitems.count
    time_into_loop=0
    streamitems.count.times do |i|
      puts streamitems[i].position
      time_into_loop+=streamitems[i+1].episode.duration
      next_time_into_loop=streamitems[i].episode.duration+time_into_loop
      if(time_into_loop <= current_time_in_loop && next_time_into_loop> current_time_in_loop)
        puts("found it")
        return streamitems[i+1]
      end
    end
    puts "reached end"
    return nil
  end

  def self.updatePlaylistFile
    streamitems = Admin::Streamitem.sorted
    File.open(Rails.root.join('lib', 'ices', 'playlist.txt'), 'w') do |f|
      streamitems.each do |streamitem|
       f.puts Rails.root.join('public', streamitem.episode.mediafile.attachment_url)
      end
    end
  end

end
