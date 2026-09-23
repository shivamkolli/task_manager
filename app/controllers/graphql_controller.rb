# frozen_string_literal: true

class GraphqlController < ApplicationController
  skip_forgery_protection

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]

    context = {
      current_user: Current.user
    }

    result = TaskManagerSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: operation_name
    )

    render json: result
  rescue StandardError => e
    Rails.logger.error(
      "GraphQL Error: #{e.class}: #{e.message}"
    )

    render json: {
      errors: [
        {
          message: "An unexpected error occurred"
        }
      ]
    }, status: :internal_server_error
  end

  private

  def request_authentication
    render json: {
      errors: [
        { message: "Authentication required" }
      ]
    }, status: :unauthorized
  end

  def prepare_variables(variables_param)
    case variables_param
    when String
      variables_param.present? ? JSON.parse(variables_param) : {}
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_h
    when nil
      {}
    else
      raise ArgumentError, "Unexpected variables parameter"
    end
  end
end
