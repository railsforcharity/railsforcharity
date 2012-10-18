class EmailTemplate

  # Constants (should always be declared at the top)
  TYPES = {
    new_task: {
      id: 1,
      description: 'Email me whenever a new task is created in this project.',
      subject: "(<%= entity.name %>) New task created"
    },
    task_delivered: {
      id: 2, description: 'Email me whenever a task status changes to "Delivered".'
    }
  }

end
