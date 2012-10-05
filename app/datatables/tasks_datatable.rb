class TasksDatatable
  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Task.count,
      iTotalDisplayRecords: tasks.total_entries,
      aaData: data
    }
  end

private

  def data
    tasks.map do |task|
      [
        link_to(task.name, task),
        h(task.description),
        h(task.type),
        h(task.estimated_time.strftime("%B %e, %Y")),
        h(task.creator.name),
        h(task.project.name),
        h(task.assignee.name)
      ]
    end
  end

  def tasks
    @tasks ||= fetch_tasks
  end

  def fetch_tasks
    tasks = Task.order("#{sort_column} #{sort_direction}")
    tasks = tasks.page(page).per_page(per_page)
    if params[:sSearch].present?
      tasks = tasks.where("name like :search or category like :search", search: "%#{params[:sSearch]}%")
    end
    tasks
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[Title, Description, Type, Estimated Time, Requested By, Project Name, Assigned to, Actions]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end