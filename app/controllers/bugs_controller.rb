class BugsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_bug, only: [:edit, :update, :destroy, :show]

  load_and_authorize_resource :project
  load_and_authorize_resource :bug, through: :project, shallow: true

  def new
    if @project
      @bug = @project.bugs.build
    else
      redirect_to projects_path, alert: 'Project not found.'
    end
  end

  def show
    @bug                                                                                                                                                                      
    # @project
  end

  def create
    @bug = @project.bugs.build(bug_params)
    @bug.developer_id = params[:bug][:developer_id] if params[:bug][:developer_id].present?
    @bug.qa_id = current_user.id if current_user.user_type == 'qa'
    @bug.manager_id = current_user.id if current_user.user_type == 'manager'

    if @bug.save
      redirect_to project_path(@project), notice: 'Bug was successfully created.'
    else
      redirect_to new_project_bug_path, alert: @bug.errors.full_messages.to_sentence
    end
  end


  def edit
    
  end

  def update
    if @bug.update(bug_params)
      redirect_to project_path(@project), notice: 'Bug was successfully updated.'
    else
      render :edit, notice: 'Please select status'
    end
  end

  def destroy
    @bug.destroy
    redirect_to project_path(@project), notice: 'Bug was successfully deleted.'
  end




  private

  def set_project
    @project = Project.find_by(id: params[:project_id])
    redirect_to projects_path, alert: 'Project not found.' unless @project
  end

  def set_bug
    @bug = @project.bugs.find_by(id: params[:id])
    redirect_to project_path(@project), alert: 'Bug not found.' unless @bug
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :screen_shot, :bug_type, :status, :developer_id, :project_id )
  end
end
