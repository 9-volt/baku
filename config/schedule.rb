RAILS_ROOT = File.dirname(__FILE__) + '/..'
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


job_type :sidekiq,  "cd :path && RAILS_ENV=:environment bundle exec sidekiq-client :task :output"
# Learn more: http://github.com/javan/whenever
set :output, "#{RAILS_ROOT}/log/whenever.log"

every 1.day, at: '1:30' do
  sidekiq "push LinksUpdater"
end

every 1.minutes do
  runner "PagesFetcher.parse_a_bunch"
end
