class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :update, :destroy ]
  before_action :is_not_exist, only: [ :create ]
  before_action :params_require, only: [ :create ]

  def index
    task = Task.all
    render json: task
  end

  def show
    render json: @task
  end

  def create
    task = Task.new(title: params[:title], done: params[:done])

    if task.save
      render json: task
    end
  end

  def destroy
    @task.destroy()
  end

  def update
    @task.title = params[:title] if params[:title]
    @task.done = params[:done] if params[:done]

    if @task.save
      render json: @task
    end
  end

  private

  def set_task
    @task = Task.find_by(params_find)

    if @task.nil?
      render json: { message: "Not found" }, status: :not_found
    end
  end

  def is_not_exist
    if Task.find_by(params_find)
      render json: { message: "Already exist" }
    end
  end

  def params_require
    unless params.key?(:title) && params.key?(:done)
      render json: { message: "Invalid parameters (body)" }, status: 400
    end
  end

  def params_find
    { id: params[:id] }
  end
end
