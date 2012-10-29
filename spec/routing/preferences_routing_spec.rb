require "spec_helper"

describe PreferencesController do
  describe "routing" do
    it "routes to #index" do
      get("/users/pratik-khadloya/preferences").should route_to({
        controller: 'preferences',
        action: 'index',
        user_id: 'pratik-khadloya'
      })
    end

    it "routes to #index with project_id" do
      get("/users/pratik-khadloya/preferences?project_id=1").should route_to({
        controller: 'preferences',
        action: 'index',
        user_id: 'pratik-khadloya'
      })
    end
  end
end
