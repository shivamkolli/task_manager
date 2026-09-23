module Types
  class QueryType < Types::BaseObject
    field :tasks, [ Types::TaskType ], null: false do
      description "Returns tasks belonging to the authenticated user"
    end

    def tasks
      current_user = context[:current_user]

      raise GraphQL::ExecutionError, "Unauthorized" unless current_user

      current_user.tasks.order(created_at: :desc)
    end
  end
end
