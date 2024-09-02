class ProjectsController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
  
    if current_user.user_type == 'qa'
      @projects = current_user.assigned_projects
    elsif current_user.user_type == 'developer'
      @projects = current_user.assigned_projects
    # elsif current_user.user_type == 'manager'
    #   @projects = Project.where(manager_id: current_user.id) # show projects which was created by the current manager
    else
      @projects = Project.all
    end

  end

  def show
    @project = Project.find(params[:id])
    if current_user.user_type == 'developer'
      @bugs = @project.bugs.where(developer_id: current_user.id) 
    else
    @bugs = @project.bugs
    end
  end

  def new
    @project = Project.new
    # @bug = Bug.new
  end

  def create
    @project = Project.new(project_params)
    @project.manager_id = current_user.id

    if params[:project][:project_name].blank?

      redirect_to new_project_path, alert: 'Project Name cannot be blank.'

    elsif params[:project][:developer_ids].blank? || params[:project][:qa_ids].blank?

      redirect_to new_project_path, alert: 'Please select at least one Developer and one QA.'

    elsif @project.save

      assign_selected_users(@project, params[:project][:developer_ids], params[:project][:qa_ids])
      redirect_to projects_path, notice: 'Project was successfully created.'

    else
      redirect_to new_project_path, alert: @project.errors.full_messages.to_sentence
    end
    
  end
  
  def edit
  end

  def update
    if params[:project][:project_name].blank?

      redirect_to edit_project_path(@project), alert: 'Project name cannot be blank.'

    elsif params[:project][:developer_ids].blank? || params[:project][:qa_ids].blank?

      redirect_to edit_project_path(@project), alert: 'Please select at least one Developer and one QA.'

    elsif @project.update(project_params)

      @project.projects_assigneds.destroy_all

      assign_selected_users(@project, params[:project][:developer_ids], params[:project][:qa_ids])
      redirect_to @project, notice: 'Project was successfully updated.'

    else

      flash.now[:alert] = @project.errors.full_messages.to_sentence
      render :edit
      
    end
  end
  
  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully deleted.'
  end


  private

  def project_params
    params.require(:project).permit(:project_name)
  end

  def assign_selected_users(project, developer_ids, qa_ids)
   
    if developer_ids.present?
      developer_ids.reject(&:blank?).each do |developer_id|
        ProjectsAssigned.find_or_create_by(project: project, user_id: developer_id)
      end
    end

    if qa_ids.present?
      qa_ids.reject(&:blank?).each do |qa_id|
        ProjectsAssigned.find_or_create_by(project: project, user_id: qa_id)
      end
    end

  end
 
end
