class TasksController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  before_filter :find_task, :only => [:edit, :show, :assign_me, :deliver, :unassigned, :accept, :reject, :update, :destroy]
  before_filter :find_user, :only => [:new, :edit, :create, :update]

  def new
    if params[:project_id] == nil
      @task = Task.new
    else
      @project = Project.find(params[:project_id])
      @task = Task.new(:project_id => @project.id)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  def create
    if params[:project_id] == nil
      @task = Task.new(params[:task])
    else
      @project = Project.find(params[:project_id])
      @task = @project.tasks.build(params[:task])
    end

    @task.creator = current_user

    respond_to do |format|
      if @task.save
        @task.tags.each { |t| t.update_attributes(:tag_type => 'task') }
        @task.project.preferences.new_task_users.each do
          |user| QC.enqueue("Emailer.send_task_email", user.id, 'new_task', @task.id)
        end

        if @project.nil?
          format.html { redirect_to :back, notice: t('controllers.tasks.create.success') }
        else
          format.html { redirect_to project_path(@project), notice: t('controllers.tasks.create.success') }
          format.json { render json: project_path(@project), status: :created, location: @task }
        end
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to :back, notice: t('controllers.tasks.update.success') }
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
    @open_tasks = Task.open_tasks.includes([:creator, :project])
    @ongoing_tasks = Task.ongoing.includes([:creator, :assignee, :project])
    @delivered_tasks = Task.delivered.includes([:creator, :assignee, :project])
    @done_tasks = Task.done.includes([:creator, :assignee, :project])
  end

  def destroy
    @task.destroy
    respond_to do |format|
      if @project.nil?
        format.html { redirect_to tasks_url }
      else
        format.html { redirect_to project_url }
        format.json { head :no_content }
      end
    end
  end

  def show
    @commentable = @task
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def assign_me
    @task.assignee = current_user
    @task.status = Task::STATUSES[:ongoing]

    if @task.save!
      if @task.creator != current_user && @task.project.preferences.task_assigned_users.include?(@task.creator)
        QC.enqueue("Emailer.send_task_email", @task.creator.id, 'task_assigned', @task.id)
      end

      redirect_to :back, notice: t('controllers.tasks.assign_me.success')
    else
      redirect_to :back, notice: t('controllers.tasks.assign_me.failure')
    end
  end

  def deliver
    @task.status = Task::STATUSES[:delivered]

    if @task.save!
      if @task.creator != current_user && @task.project.preferences.task_delivered_users.include?(@task.creator)
        QC.enqueue("Emailer.send_task_email", @task.creator.id, 'task_delivered', @task.id)
      end
      redirect_to :back, notice: t('controllers.tasks.deliver.success')
    else
      redirect_to :back, notice: t('controllers.tasks.deliver.failure')
    end
  end

  def unassigned
    @task.assigned_to = nil
    @task.status = Task::STATUSES[:open]

    if @task.save!
      if @task.creator != current_user && @task.project.preferences.task_unassigned_users.include?(@task.creator)
        QC.enqueue("Emailer.send_task_email", @task.creator.id, 'task_unassigned', @task.id)
      end
      redirect_to :back, notice: t('controllers.tasks.unassign.success')
    else
      redirect_to :back, notice: t('controllers.tasks.unassign.failure')
    end
  end

  def accept
    @task.status = Task::STATUSES[:done]

    if @task.save!
      if @task.assignee != @task.creator && @task.project.preferences.task_accepted_users.include?(@task.assignee)
        QC.enqueue("Emailer.send_task_email", @task.assignee.id, 'task_accepted', @task.id)
      end
      redirect_to :back, notice: t('controllers.tasks.accept.success')
    else
      redirect_to :back, notice: t('controllers.tasks.accept.failure')
    end
  end

  def reject
    @task.status = Task::STATUSES[:ongoing]

    if @task.save!
      if @task.assignee != @task.creator && @task.project.preferences.task_rejected_users.include?(@task.assignee)
        QC.enqueue("Emailer.send_task_email", @task.assignee.id, 'task_rejected', @task.id)
      end
      redirect_to :back, notice: t('controllers.tasks.reject.success')
    else
      redirect_to :back, notice: t('controllers.tasks.reject.failure')
    end
  end

  private

  def find_user
    @user = current_user
  end

  def find_task
    @task = Task.find(params[:id])
  end

  def find_project
    @project = Project.find(params[:project_id])
  end
end
