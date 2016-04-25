class TasksController < ApplicationController
  def index
    @tasks= Task.order(created_at: :asc)
    render json: {tasks: @tasks}
  end

  def create
    if @task = Task.create(task_params)
    render json: { task: @task, location: task_url(@task)}, status: :created
    else
    render json: { errors: @task.errors }, status: :unprocessable_entity
    end
  end


  def show
    @task = Task.find(params[:id])
    render json: { task:@task}
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
    render json: { task: @task}, status: :accepted
  else
    render json: {errors: @task.errors}, status: :unprocessable_entity
  end
end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    render json: { task: nil }, status: :accepted
  end

  protected

  def task_params
    params.require(:task).permit(:title, :completed)
  end

end
