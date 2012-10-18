require "spec_helper"

describe EmailPreferencesController do
  describe "routing" do

    it "routes to #index" do
      get("/email_preferences").should route_to("email_preferences#index")
    end

    it "routes to #new" do
      get("/email_preferences/new").should route_to("email_preferences#new")
    end

    it "routes to #show" do
      get("/email_preferences/1").should route_to("email_preferences#show", :id => "1")
    end

    it "routes to #edit" do
      get("/email_preferences/1/edit").should route_to("email_preferences#edit", :id => "1")
    end

    it "routes to #create" do
      post("/email_preferences").should route_to("email_preferences#create")
    end

    it "routes to #update" do
      put("/email_preferences/1").should route_to("email_preferences#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/email_preferences/1").should route_to("email_preferences#destroy", :id => "1")
    end

  end
end
