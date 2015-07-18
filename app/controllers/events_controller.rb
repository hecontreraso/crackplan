class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:join, :edit, :create, :update, :destroy]
  
  layout "internal"

  # POST /events/:id/toggle_assistance
  def toggle_assistance
    returned_state = current_user.toggle_assistance(set_event, current_user)
    render json: { returned_state: returned_state }    
  end 

  # GET /events
  # GET /events.json
  def index
    @event = Event.new
    @events = Event.all.order(created_at: :desc).decorate

    @events.collect do |event|
      event.creator = UserDecorator.new(event.creator)
      if current_user
        event.going_or_join = current_user.is_going_to?(event) ? "Going" : "Join"
      end
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    event_params[:time] = event_params[:time].to_time

    @event = Event.new(event_params)
    @event.creator = current_user

    respond_to do |format|
      if @event.save

        @event.creator = UserDecorator.new(@event.creator)

        current_user.join_event(@event)
        
        format.html { redirect_to events_path }
        format.js {}
        format.json { render :show, status: :created, location: @event }
      else
        format.html { redirect_to events_path }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:details, :where, :date, :time, :image)
    end
end
