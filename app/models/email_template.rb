class EmailTemplate

  # Constants (should always be declared at the top)
  TYPES = {
    new_task: {
      id: 1,
      description: 'A new task is created.',
      subject: "(<%= project.name %>) New task created"
    },
    task_assigned: {
      id: 2,
      description: "A task is assigned to someone.",
      subject: "(<%= project.name %>) task assigned"
    },
    task_unassigned: {
      id: 3,
      description: 'A task is unassigned from someone.',
      subject: "(<%= project.name %>) task unassigned"
    },
    task_delivered: {
      id: 4,
      description: 'A task is delivered.',
      subject: "(<%= project.name %>) task delivered"
    },
    task_accepted: {
      id: 5,
      description: 'A task is accepted.',
      subject: "(<%= project.name %>) task accepted"
    },
    task_rejected: {
      id: 6,
      description: 'A task is rejected.',
      subject: "(<%= project.name %>) task rejected"
    },
  }

end
