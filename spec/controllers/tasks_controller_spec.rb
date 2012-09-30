require 'spec_helper'

describe TasksController do
  def valid_attributes
    {
      name: Faker.name,
      description: 'To build open source web based applications which help in improving the society.',
      estimated_hours: 2,
      estimated_minutes: 40,
      category: Task::CATEGORIES[:programming],
      task_type: Task::TYPES[:feature],
      project_id: 1
    }
  end

  let(:user) { create(:user) }

  before(:each) do
    @project = create(:project)
  end

  describe "POST create" do
    login_user

    describe "with valid params" do
      before :each do
        request.env["HTTP_REFERER"] = '/'
      end

      it "creates a new Task" do
        expect {
          post :create, { :task => valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "assigns a newly created task as @task" do
        post :create, { :task => valid_attributes }
        assigns(:task).should be_a(Task)
        assigns(:task).should be_persisted
        assigns(:task).estimated_time.should_not be_nil
        assigns(:task).estimated_time.should == 160
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved task as @task" do
        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        post :create, {:task => {}}
        assigns(:task).should be_a_new(Task)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        post :create, {:task => {}}
        response.should render_template("new")
      end
    end
  end

  describe "assign to self" do
    login_user

    pending "assigns the task to the current user" do
      task = create(:task)
      @request.env['HTTP_REFERER'] = project_path(@project)
      post :assign_me, { :id => task.to_param }
      puts task.inspect
      task.assigned_to.should_not be_nil
      task.assigned_to.should == @user.id
    end
  end
end
