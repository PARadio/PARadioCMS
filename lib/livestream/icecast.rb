class Livestream::Icecast

  def self.writeConfig
    icecastxml = File.open(Livestream::Config.icecast_config_fullpath) { |f| Nokogiri::XML(f) }

    Livestream::Config.icecast_config.each do |key, value|
      setting = icecastxml.at_css(key)
      setting.content = value
    end

    File.write(Livestream::Config.icecast_config_fullpath, icecastxml.to_xml)
  end

  def self.readConfig
    icecastxml = File.open(Livestream::Config.icecast_config_fullpath) { |f| Nokogiri::XML(f) }

    Livestream::Config.icecast_config.each do |key, value|
      setting = icecastxml.at_css(key)
      Livestream::Config.icecast_config[key] = setting.content
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
