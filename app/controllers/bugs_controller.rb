class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  load_and_authorize_resource
  
  def new
    if @project
      @bug = @project.bugs.build
    else
      redirect_to projects_path, alert: 'Project not found.'
    end
  end

  def show
    @bugs = @project.bugs
  end

  def create
    @bug = @project.bugs.build(bug_params)
    @bug.developer_id = current_user.id if current_user.user_type == 'developer'
    @bug.qa_id = current_user.id if current_user.user_type == 'qa'

    if @bug.save
      redirect_to project_path(@project), notice: 'Bug was successfully created.'
    else
      render :new
    end
  end

  private

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end


  def bug_params
    params.require(:bug).permit(:title, :description, :project_id, :type, :status)
  end

end
