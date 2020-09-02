# frozen_string_literal: true

class TodosController < ApplicationController
  before_action :set_project
  before_action :set_project_todo, only: %i[show update destroy]

  # GET /projects/:project_id/todos
  def index
    json_response(@project.todos)
  end

  # GET /projects/:project_id/todos/:id
  def show
    json_response(@todo)
  end

  # POST /projects/:project_id/todos
  def create
    @project.todos.create!(todo_params)
    json_response(@project, :created)
  end

  # PUT /projects/:project_id/todos/:id
  def update
    @todo.update(todo_params)
    head :no_content
  end

  # DELETE /projects/:project_id/todos/:id
  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def todo_params
    params.permit(:title, :progress)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_project_todo
    @todo = @project.todos.find_by!(id: params[:id]) if @project
  end
end
