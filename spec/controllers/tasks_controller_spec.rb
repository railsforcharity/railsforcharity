require 'spec_helper'

describe TasksController do
  let(:project) { create(:project_with_creator) }

  def valid_attributes
    {
      name: Faker.name,
      description: 'To build open source web based applications which help in improving the society.',
      estimated_hours: 2,
      estimated_minutes: 40,
      category: Task::CATEGORIES[:programming],
      task_type: Task::TYPES[:feature],
      project_id: project.id
    }
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

      it 'emails the collaborators' do
        Emailer.should_receive(:send_email).with(project.users, :new_task, project).and_return(double('mailer', :deliver => true))
        post :create, { :task => valid_attributes }
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

  def update
    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: t('controllers.tasks.update.success') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  describe "assign_me" do
    login_user

    it "assigns the task to the current user" do
      @request.env['HTTP_REFERER'] = project_path(project)
      task = create(:task, :creator => user, :estimated_hours => 4, project: project)

      put :assign_me, { :id => task.to_param }
      task.reload
      task.assigned_to.should_not be_nil
      task.assigned_to.should == user.id
      task.estimated_hours.should == 4
    end
  end
end
