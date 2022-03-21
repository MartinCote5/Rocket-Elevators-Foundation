env :PATH, ENV['PATH']
env :DATABASE_USERNAME, ENV['DATABASE_USERNAME']
env :DATABASE_PASSWORD, ENV['DATABASE_PASSWORD']

set :environment, "development"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

# Here we need to check when to run the job
# rake will use the task we set it out to do
every :day, at: '1:17am' do
    rake 'psql:send'
end
