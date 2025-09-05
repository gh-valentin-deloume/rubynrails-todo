class TasksController < ApplicationController
  before_action :set_task, only: %i[show update destroy]
  before_action :is_not_exist, only: [:create]
  #before_action :params_require, only: [:create]
  before_action :authenticate_user!

  def index
    task = Task.all
    render json: task
  end

  def show
    render json: @task
  end

  def create
    task = Task.new(title: params[:title], done: params[:done])

    unless task.save
      render json: {message: task.errors.full_messages.to_sentence}
      return
    end

    render json: task
  end

  def destroy
    @task.destroy
  end

  def update
    @task.title = params[:title] if params.key?(:title)
    @task.done = params[:done] if params.key?(:done)

    return unless @task.save

    render json: @task
  end

  private

  def set_task
    @task = Task.find_by(params_find)

    return unless @task.nil?

    render json: { message: 'Not found' }, status: :not_found
  end

  def is_not_exist
    return unless Task.find_by(params_find)

    render json: { message: 'Already exist' }
  end

  def params_require
    return if params.key?(:title) && params.key?(:done)

    render json: { message: 'Invalid parameters (body)' }, status: 400
  end

  def params_find
    { id: params[:id] }
  end
end
