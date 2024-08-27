class ProjectsController < ApplicationController

  load_and_authorize_resource

  before_action :authenticate_user!

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
    @bugs = @project.bugs
  end

  def new
   
    @project = Project.new
    # @bug = Bug.new
    
  end

  def create
   
    @project = Project.new(project_params)
    @project.manager_id = current_user.id

    if @project.save
      assign_selected_users(@project, params[:project][:developer_ids], params[:project][:qa_ids])
      redirect_to projects_path, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def edit
  end


  def update
    if @project.update(project_params)
      # Clear existing assignments
      @project.projects_assigneds.destroy_all
      
      # Assign selected developers and QAs
      assign_users(@project, params[:project][:developer_ids], 'developer')
      assign_users(@project, params[:project][:qa_ids], 'qa')

      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully deleted.'
  end





  private

  def project_params
    params.require(:project).permit(:project_name, :manager_id)
  end

  def assign_users(project, user_ids, user_type)
    return unless user_ids

    user_ids.each do |user_id|
      ProjectsAssigned.create(project: project, user_id: user_id) unless ProjectsAssigned.exists?(project: project, user_id: user_id)
    end
  end

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
