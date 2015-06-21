class API::EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :set_access_control_headers

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
      puts "*" * 100
      puts params
      puts "*" * 100
      
      registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])

      if nil == registered_application
        render json: "Unregistered application", status: :unprocessable_entity and return
      end

      @event = registered_application.events.build(event_params)
      if @event.save
        render json: @event, status: :created
      else
        render @event.errors, status: :unprocessable_entity
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

  def set_access_control_headers
 # #1
     headers['Access-Control-Allow-Origin'] = '*'
 # #2
     headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
 # #3
     headers['Access-Control-Allow-Headers'] = 'Content-Type'
   end

  private

  def event_params
    params.require(:event).permit(:name)
  end

end
