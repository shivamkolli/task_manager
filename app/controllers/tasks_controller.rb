class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update destroy]

  def index
    @tasks = Current.user.tasks.order(created_at: :desc)

    @tasks = @tasks.search(params[:query]) if params[:query].present?
  end

  def new
    @task = Current.user.tasks.new
  end

  def create
    @task = Current.user.tasks.new(task_params)

    if @task.save
      respond_to do |format|
        format.html do
          redirect_to tasks_path, notice: "Task created successfully."
        end

        format.turbo_stream do
          flash.now[:notice] = "Task created successfully."
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html do
          redirect_to tasks_path, notice: "Task updated successfully."
        end

        format.turbo_stream do
          flash.now[:notice] = "Task updated successfully."
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html do
        redirect_to tasks_path, notice: "Task deleted successfully."
      end

      format.turbo_stream do
        flash.now[:notice] = "Task deleted successfully."
      end
    end
  end

  private

  def set_task
    @task = Current.user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(
      :title,
      :description,
      :status,
      :priority,
      :due_date
    )
  end
end
