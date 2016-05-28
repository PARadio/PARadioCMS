class Livestream::Config

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

  def self.start_time (date = Time.now)
    t = Time.now
    if t.saturday? || t.sunday?
      return Time.parse("09:00 AM")
    else
      return Time.parse("05:00 PM")
    end
  end

  def self.end_time (date = Time.now)
    t = Time.now
    if t.saturday? || t.sunday?
      return Time.parse("11:00 PM")
    else
      return Time.parse("11:00 PM")
    end
  end
end
