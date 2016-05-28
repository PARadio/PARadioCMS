class Livestream::Icecast

  #
  # Icecast settings
  #
  @@icecast_config_fullpath = Rails.root.join('lib', 'livestream', 'icecast.xml')

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

  def self.writeConfig
    icecastxml = File.open(@@icecast_config_fullpath) { |f| Nokogiri::XML(f) }

    @@icecast_config.each do |key, value|
      setting = icecastxml.at_css(key)
      setting.content = value
    end

    File.write(@@icecast_config_fullpath, icecastxml.to_xml)
  end

  def self.readConfig
    icecastxml = File.open(@@icecast_config_fullpath) { |f| Nokogiri::XML(f) }

    @@icecast_config.each do |key, value|
      setting = icecastxml.at_css(key)
      @@icecast_config[key] = setting.content
    end
  end

  def self.streamFile(stream, filename)
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
