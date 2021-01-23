# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.includes(:participants).all

    render json: @projects, include: :participants, status: 200
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    render json: @project, include: :participants, status: 200
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit; end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    if @project.save
      render json: @project, status: 200
    else
      render json: { errors: @project.errors.messages }, status: 200
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if @project.update(project_params)
      render json: @project, status: 200
    else
      render json: { errors: @project.errors.messages }, status: 200
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy

    head :no_content
  end

  def check_investment
    investment = BigDecimal(params[:investment])
    project = Project.find(params[:id])

    amount = project.amount

    if investment < amount
      render json: { error: 'O valor do investimento não pode ser menor que o do projeto!' }, status: 400
    else
      render json: { data: project.roi(investment) }, status: 200
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name, :start_date, :finish_date, :amount, :risk,
                                    participants_attributes: [:id, :name, :_destroy])
  end
end
