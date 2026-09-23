module Mutations
  class UpdateTask < Mutations::BaseMutation
    description "Updates a task belonging to the authenticated user"

    argument :id, ID, required: true
    argument :input, Types::TaskInputType, required: true

    field :task, Types::TaskType, null: true
    field :errors, [ String ], null: false

    def resolve(id:, input:)
      current_user = context[:current_user]

      unless current_user
        return {
          task: nil,
          errors: [ "Unauthorized" ]
        }
      end

      task = current_user.tasks.find_by(id: id)

      unless task
        return {
          task: nil,
          errors: [ "Task not found" ]
        }
      end

      if task.update(input.to_h)
        {
          task: task,
          errors: []
        }
      else
        {
          task: nil,
          errors: task.errors.full_messages
        }
      end
    end
  end
end
