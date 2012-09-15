require 'spec_helper'

describe TasksController do
  def valid_attributes
    {
        name: Faker.name,
        description: 'To build open source web based applications which help in improving the society.',
        hours: 4,
        task_type: "chore"
    }
  end

  before(:each) do
    @project = create(:project)
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProjectsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new', {:project_id => @project.id}
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Task" do
        expect {
          post :create, { :task => valid_attributes, :project_id => @project.id }, valid_session
        }.to change(Task, :count).by(1)
      end

      it "assigns a newly created task as @task" do
        post :create, {:task => valid_attributes, :project_id => @project.id}, valid_session
        assigns(:task).should be_a(Task)
        assigns(:task).should be_persisted
      end

      it "redirects to the created task" do
        post :create, {:task => valid_attributes, :project_id => @project.id}, valid_session
        response.should redirect_to(new_project_task_path(@project))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved task as @task" do
        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        post :create, {:task => {}, :project_id => @project.id}, valid_session
        assigns(:task).should be_a_new(Task)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        post :create, {:task => {},:project_id => @project.id }, valid_session
        response.should render_template("new")
      end
    end
  end

end
