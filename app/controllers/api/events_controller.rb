class API::EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
     registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])
     
     if !registered_application
       render json: "Unregistered application", status: :unprocessable_entity
     else
       @event = registered_application.events.new(event_params)
       if @event.save
        render json:@event, status: :created
       else
        render json:@event.errors, status: :unprocessable_entity
       end
     end
  end

  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update(events_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def events_params
    params.require(:event).permit(:name)
  end

end
