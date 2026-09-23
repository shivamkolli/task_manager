module Types
  class TaskInputType < Types::BaseInputObject
    description "Input for creating or updating a task"

    argument :title, String, required: false
    argument :description, String, required: false
    argument :status, Types::TaskStatusEnum, required: false
    argument :priority, Types::TaskPriorityEnum, required: false
  end
end
