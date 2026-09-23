module Types
  class TaskStatusEnum < Types::BaseEnum
    value "PENDING", value: "pending"
    value "IN_PROGRESS", value: "in_progress"
    value "COMPLETED", value: "completed"
  end
end
