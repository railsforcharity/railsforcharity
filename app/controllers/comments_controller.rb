class CommentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :find_commentable
  before_filter :find_comment, :only => [:destroy, :update, :edit]

  def index
    @commentable = Task.find(params[:task_id])
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new(:parent_id => params[:parent_id])
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    @comment.created_by = current_user
    if @comment.save
      redirect_to task_path(@commentable), notice: t("controllers.comments.create.success")
    else
      redirect_to :back
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes((params[:comment]))
      redirect_to @commentable, notice: t("controllers.comments.update.success")
    else
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :back, :notice => t("controllers.comments.delete.success") }
      format.json { head :no_content }
    end
  end

private

  def find_commentable
    resource, id = request.path.split('/')[1, 2]
    #resource = 'task' if resource_char == 't'
    #resource = 'project' if resource_char == 'p'
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end