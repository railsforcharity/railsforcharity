class TasksController < ApplicationController
  before_filter :find_project, :only => [:update, :show, :edit, :update]
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :find_task, :only => [:edit, :show, :assign_me, :finish, :unassigned, :update]


  def new
    @user = current_user
    @task = Task.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  def create
    #@project = Project.find(project_id)
    @task = Task.new(params[:task])
    @task.status = Task::STATUSES[:open]
    @task.creator = current_user

    respond_to do |format|
      if @task.save
        @task.tags.each {|t| t.update_attributes(:tag_type => 'task')}
        format.html { redirect_to  :back, notice: t('controllers.tasks.create.success') }
        format.json { render json:  :back, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to project_task_path(@project, @task), notice: t('controllers.tasks.update.success') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def index
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  def show
    @commentable = @task
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def assign_me
    @task.assigned_to = current_user.id
    @task.status = Task::STATUSES[:ongoing]
    if @task.save!
      redirect_to :back, notice: t('controllers.tasks.assign_me.success')
    else
      redirect_to :back, notice: t('controllers.tasks.assign_me.failure')
    end
  end

  def finish
    @task.status = Task::STATUSES[:closed]
    if @task.save!
      redirect_to :back, notice: t('controllers.tasks.finish.success')
    else
      redirect_to :back, notice: t('controllers.tasks.finish.failure')
    end
  end

  def unassigned
    @task.status = Task::STATUSES[:open]
    @task.assigned_to= nil
    if @task.save!
      redirect_to :back, notice: t('controllers.tasks.unassign.success')
    else
      redirect_to :back, notice: t('controllers.tasks.unassign.failure')
    end
  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def find_project
    @project = Project.find(params[:project_id])
  end
end
