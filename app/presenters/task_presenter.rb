class TaskPresenter < ApplicationPresenter
  require 'active_support/inflector'
  presents :task

  #def estimated_time
  #  "#{task.estimated_hours} hr #{task.estimated_minutes} minutes"
  #end

  def estimated_time
    if (task.estimated_hours && task.estimated_minutes) != 0
      "#{task.estimated_hours} hr #{task.estimated_minutes} minutes"
    elsif (task.estimated_hours == 0) && (task.estimated_minutes == 0)
      return nil
    elsif task.estimated_hours == 0
      "#{task.estimated_minutes} minutes"
    elsif task.estimated_minutes == 0
      "#{task.estimated_hours} hr"
    end
  end

  def creator_name
    task.creator.name
  end

  def assignee_name
    task.assignee.name
  end
end