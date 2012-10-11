class TasksController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :find_task, :only => [:edit, :show, :assign_me, :deliver, :unassigned, :accept, :reject, :update, :destroy]
  before_filter :find_user, :only => [:new, :edit, :create, :update]

  def new
    @task = Task.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  def create
    @task = Task.new(params[:task])
    puts @task.inspect
    @task.status = Task::STATUSES[:open]
    @task.creator = current_user

    respond_to do |format|
      if @task.save
        @task.tags.each {|t| t.update_attributes(:tag_type => 'task')}
        format.html { redirect_to :back, notice: t('controllers.tasks.create.success') }
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
    @tasks = Task
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

  def deliver
    @task.status = Task::STATUSES[:delivered]
    if @task.save!
      redirect_to :back, notice: t('controllers.tasks.deliver.success')
    else
      redirect_to :back, notice: t('controllers.tasks.deliver.failure')
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


  def accept
    @task.status = Task::STATUSES[:done]
    if @task.save!
      redirect_to :back, notice: t('controllers.tasks.accept.success')
    else
      redirect_to :back, notice: t('controllers.tasks.accept.failure')
    end
  end

  def reject
    @task.status = Task::STATUSES[:ongoing]
    if @task.save!
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

end
