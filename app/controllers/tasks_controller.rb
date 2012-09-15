class TasksController < ApplicationController
  before_filter :find_project, :only => [:new, :create, :update]

  def new
    @task = Task.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  def create
    @task = @project.tasks.build(params[:task])
    #@task.creator = current_user
    respond_to do |format|
      if @task.save
        @task.tags.each {|t| t.update_attributes(:tag_type => 'task')}
        format.html { redirect_to new_project_task_path(@project), notice: t('controllers.tasks.create.success') }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def index
  end

  def show
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end
end
