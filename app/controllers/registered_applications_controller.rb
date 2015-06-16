class RegisteredApplicationsController < ApplicationController
  def index
    @registered_application = RegisteredApplication.all
  end

  def show
    @registered_application = RegisteredApplication.find(params[:id])
    @events = @registered_application.events.group_by(&:name)
  end

  def new
    @registered_application = RegisteredApplication.new
  end

  def create
    @registered_application = RegisteredApplication.new(registered_applications_params)
    @registered_application.user_id = current_user.id
    if @registered_application.save
      flash[:notice] = 'Website was successfully added.'
      redirect_to registered_applications_path
    else
      flash[:error] = 'There was an error while adding your website.'
      render :new
    end
  end

  def edit
     @registered_application = RegisteredApplication.find(params[:id])
  end

  def update
    registered_application = RegisteredApplication.find(params[:id])
    if registered_application.update_attributes(registered_applications_params)
      flash[:notice] = 'Website was saved successfully.'
      redirect_to registered_applications_path
    else
      flash[:error] = 'There was an error while saving your website.'
      render :update
    end
  end

  def destroy
    registered_application = RegisteredApplication.find(params[:id])
    registered_application.destroy
    flash[:notice] = 'The website was deleted successfully.'
    redirect_to registered_applications_path
  end

  private

  def registered_applications_params
    params.require(:registered_application).permit(:id, :url)
  end
end
