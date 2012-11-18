require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'email_spec'
  require 'rspec/autorun'
  require 'rspec/rails'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.include EmailSpec::Helpers
    config.include EmailSpec::Matchers
    config.include(MailerMacros)
    config.before(:each) { reset_email }

    config.include Devise::TestHelpers, :type => :controller
    config.extend ControllerMacros, :type => :controller
    config.include ActionView::TestCase::Behavior, example_group: {file_path: %r{spec/presenters}}

    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"

    config.include FactoryGirl::Syntax::Methods

    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true
  end

  # Factory Helpers
  def words(num, separator = " ")
    Faker::Lorem.words(num).join(separator)
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  # Note: You can modify files loaded *from* the Spork.each_run block without
  # restarting the spork server.  However, this file itself will not be reloaded,
  # so if you change any of the code inside the each_run block, you still need to
  # restart the server.  In general, if you have non-trivial code in this file,
  # it's advisable to move it into a separate file so you can easily edit it
  # without restarting spork.  (For example, with RSpec, you could move
  # non-trivial code into a file spec/support/my_helper.rb, making sure that the
  # spec/support/* files are require'd from inside the each_run block.)
  #
  # Any code that is left outside the two blocks will be run during preforking
  # *and* during each_run -- that's probably not what you want.
  FactoryGirl.reload
end