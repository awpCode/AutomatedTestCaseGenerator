class ProjectsController < ApplicationController
  def show
  @project = Project.find(params[:id])
  end
  def index
  @projects =  current_user.projects
  end
  def new
    @project = Project.new
  end
  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      flash[:notice] = "Project was created successfully."
      redirect_to project_path(@project)
    else
      render 'new'
    end
  end

  private
  def project_params
    params.require(:project).permit(:name,:script)
  end
end
