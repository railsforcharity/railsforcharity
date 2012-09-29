class TaskPresenter < ApplicationPresenter
  presents :task

  def estimated_time
    "#{task.estimated_hours} hr #{task.estimated_minutes} minutes"
  end

  def creator_name
    task.creator.name
  end

  def assignee_name
    task.assignee.name
  end

end