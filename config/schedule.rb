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

set :output, "/home/ubuntu/apps/PARadioCMS/current/lib/ices/cron_log.log"
set :environment, 'production'

every 1.day, :at => '5:00 am' do
  runner "Admin::Streamitem.updatePlaylistFile"
  command "/usr/bin/icecast2 -c /home/ubuntu/apps/PARadioCMS/current/lib/ices/icecast.xml"
  command "/usr/bin/ices2 /home/ubuntu/apps/PARadioCMS/current/lib/ices/ices.xml"
end

every 1.day, :at => '11:00 pm' do
  command "killall ices2"
  command "killall icecast2"
end
