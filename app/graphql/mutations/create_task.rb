module Mutations
  class CreateTask < Mutations::BaseMutation
    description "Creates a task for the authenticated user"

    argument :input, Types::TaskInputType, required: true

    field :task, Types::TaskType, null: true
    field :errors, [ String ], null: false

    def resolve(input:)
      current_user = context[:current_user]

      unless current_user
        return {
          task: nil,
          errors: [ "Unauthorized" ]
        }
      end

      task = current_user.tasks.new(input.to_h)

      if task.save
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
