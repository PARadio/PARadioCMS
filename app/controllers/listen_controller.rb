class ListenController < ApplicationController
  layout 'main'
  def index
    # require File.join(Rails.root, "vendor/cache/ruby/2.2.0/gems/ruby-shout-2.2.1/lib/shout")
    #
    # blocksize = 16384
    #
    # s = Shout.new
    # s.mount = "/livestream"
    # # s.charset = "UTF-8"
    # # s.mount = "/utf8"
    # s.host = "localhost"
    # s.port = 8000
    # s.user = "source"
    # s.pass = "hackme"
    # s.format = Shout::MP3
    # s.description ='çaffé düdeldø … dikşîne ΞŁΞϾТЯФЛłϾ MUSłϾ  ☼ ☺'
    #
    # s.connect
    #
    # puts "open VLC and open network -> http://#{s.host}:#{s.port}/example"
    #
    # filename = "/home/sean/Downloads/Magnolias Dripping w Molasses- PAJE.mp3"
    #
    # File.open(filename) do |file|
    #   puts "sending data from #{filename}"
    #   m = ShoutMetadata.new
    #   m.add 'filename', filename
    #   m.add 'title', 'title ☼ ☺'
    #   s.metadata = m
    #
    #   while data = file.read(blocksize)
    #     s.send data
    #     s.sync
    #   end
    # end
    #
    # s.disconnect

    @currentItem = Streamitem.getCurrent
  end
end
