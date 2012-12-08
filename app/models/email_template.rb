class EmailTemplate

  # Constants (should always be declared at the top)
  TYPES = {
    new_task: {
      id: 1,
      description: 'Any new task is created in this project.',
      subject: "(<%= project.name %>) New task"
    },

    task_assigned: {
      id: 2,
      description: "A task you created is assigned to someone.",
      subject: "(<%= project.name %>) Task assigned"
    },

    task_unassigned: {
      id: 3,
      description: 'A task you created is no longer assigned to someone.',
      subject: "(<%= project.name %>) Task unassigned"
    },

    task_delivered: {
      id: 4,
      description: 'A task you created is delivered by someone.',
      subject: "(<%= project.name %>) Task delivered"
    },

    task_accepted: {
      id: 5,
      description: 'A task you delivered is accepted by the task creator.',
      subject: "(<%= project.name %>) Task accepted"
    },

    task_rejected: {
      id: 6,
      description: 'A task you delivered is rejected by the task creator.',
      subject: "(<%= project.name %>) Task rejected"
    }
  }
end
