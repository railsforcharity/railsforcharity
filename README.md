# Rails for Charity


[![Build Status](https://secure.travis-ci.org/railsforcharity/railsforcharity.png)](http://travis-ci.org/railsforcharity/railsforcharity)

[Rails for Charity (RFC)](http://railsforcharity.com) 's mission is to build open source web based applications which help in improving the society.




### Setting up development environment


You'll need [rvm](http://rvm.beginrescueend.com).  We're using Ruby 1.9.3 and Rails 3.2, and there's an `.rvmrc` file which will help make sure you are using the right version of ruby.

[Fork us on github](https://github.com/railsforcharity/railsforcharity)

```
git clone https://github.com/railsforcharity/railsforcharity.git
cd railsforcharity
bundle install
# if you get an error and don't have a bundler installed run: gem install bundler
rake db:refresh
rails s
```

Go to http://localhost:3000/ and play with the app.