class TaskPresenter < ApplicationPresenter
  presents :task

  def estimated_time
    "#{task.estimated_hours} hr #{task.estimated_minutes} minutes"
  end

end