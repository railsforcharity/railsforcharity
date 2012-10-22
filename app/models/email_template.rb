class EmailTemplate

  # Constants (should always be declared at the top)
  TYPES = {
    new_task: {
      id: 1,
      description: 'Email me whenever a new task is created in this project.',
      subject: "(<%= project.name %>) New task created"
    },
    task_assigned: {
      id: 2,
      description: 'Email me whenever a task status changes to "assigned".',
      subject: "(<%= project.name %>) task assigned"
    },
    task_unassigned: {
      id: 3,
      description: 'Email me whenever a task status changes to "Unassigned".',
      subject: "(<%= project.name %>) task unassigned"
    },
    task_delivered: {
      id: 4,
      description: 'Email me whenever a task status changes to "delivered".',
      subject: "(<%= project.name %>) task delivered"
    },
    task_accepted: {
      id: 5,
      description: 'Email me whenever a task status changes to "accepted".',
      subject: "(<%= project.name %>) task accepted"
    },
    task_rejected: {
      id: 6,
      description: 'Email me whenever a task status changes to "rejected".',
      subject: "(<%= project.name %>) task rejected"
    },
  }

end
