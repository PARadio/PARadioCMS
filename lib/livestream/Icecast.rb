class Icecast

  #
  # Icecast settings
  #
  @@icecast_config_fullpath = Rails.root.join('lib', 'icecast.xml')

  # keys for config written in css xml query form
  @@icecast_config = {
    'location'                       => 'Earth',
    'admin'                          => 'localhost@localhost',
    'limits clients'                 => 1000,
    'authentication source-password' => 'hackme',
    'authentication admin-user'      => 'admin',
    'authentication admin-password'  => 'hackme',
    'hostname'                       => 'localhost',
    'listen-socket port'             => 8000,
    'paths logdir'                   => Rails.root.join('log'),
    'logging accesslog'              => 'icecast_access.log',
    'logging errorlog'               => 'icecast_error.log',
    'logging loglevel'               => 4
  }

  def self.start_time
    t = Time.now
    if t.saturday? || t.sunday?
      return Time.parse("09:00 AM")
    else
      return Time.parse("05:00 PM")
    end
  end

  def self.end_time
    t = Time.now
    if t.saturday? || t.sunday?
      return Time.parse("11:00 PM")
    else
      return Time.parse("11:00 PM")
    end
  end

  def self.updateIcecastSettings
    icecastxml = File.open(@@icecast_config_fullpath) { |f| Nokogiri::XML(f) }

    @@icecast_config.each do |key, value|
      icecastxml.at_css(key).first = value
    end

    File.write(@@icecast_config_fullpath, icecastxml.to_xml)
  end

  def self.runStream
    require File.join(Rails.root, "vendor/cache/ruby/2.2.0/gems/ruby-shout-2.2.1/lib/shout")

    blocksize = 16384

    s = Shout.new
    s.mount = "/livestream"
    # s.charset = "UTF-8"
    # s.mount = "/utf8"
    s.host = @@icecast_config['hostname']
    s.port = @@icecast_config['port']
    s.user = "source"
    s.pass = @@icecast_config['authentication source-password']
    s.format = Shout::MP3
    s.description ='Pinkerton Radio Livestream'

    s.connect

    streamitems = Streamitem.getToday

    while Time.now < Livestream.end_time do
      streamitems.each do |streamitem|
        filename = Rails.root.join('public', streamitem.episode.mediafile.attachment_url)
        File.open(filename) do |file|
          m = ShoutMetadata.new
          m.add 'filename', filename
          m.add 'title', streamitem.episode.name
          s.metadata = m

          while data = file.read(blocksize)
            s.send data
            s.sync
          end
        end
      end
    end

    s.disconnect
  end

end
