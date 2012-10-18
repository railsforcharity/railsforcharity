require 'spec_helper'

describe "EmailPreferences" do
  describe "GET /email_preferences" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get email_preferences_path
      response.status.should be(200)
    end
  end
end
