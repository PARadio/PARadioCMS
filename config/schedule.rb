# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, File.join(Whenever.path, "log", "whenever.log") # "/home/ubuntu/apps/PARadioCMS/current/log/whenever.log"
set :environment, 'production'

every 1.day, :at => '00:00 AM' do
  runner "Livestream.delay(run_at: Livestream::Config.start_time).runStream"
  #command "killall icecast2"
  #command "/usr/bin/icecast2 -c /home/ubuntu/apps/PARadioCMS/current/lib/ices/icecast.xml"
end
