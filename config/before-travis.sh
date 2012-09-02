bundle exec rake db:create:all
bundle exec rake db:migrate
cp config/database.travis.yml config/database.yml
sh -e /etc/init.d/xvfb start
