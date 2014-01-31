# set up the simple_feed
#   https://github.com/JumpstartLab/simple_feed
#   might need to install 1.9.3
#   if so, might need to install bundler
#
#   brew install postgresql
#   pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
#
#   bundle exec rake db:migrate
#   bundle exec rake db:seed
# create a user
# add some items
# hit the api in the browser
#   http://localhost:3000/api/feeds/YOUR_NAME_HERE/items.json
# open pry, hit the api with RestClient
# make a simple_feed_client directory
# add a test and a file
# copy the json out of the response and paste it into your tests
#   turn the json into your integration test
# go make the tests pass
#   add unit tests as necessary
# wrap the integration test with VCR
