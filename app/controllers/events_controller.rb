class EventsController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

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

    feeds = current_user.feeds.sort_by(&:created_at).reverse 
      
    @rendered_events = []

    feeds.collect do |feed|
      rendered_event = RenderedEvent.new

      rendered_event.event_id = feed.event.id
      rendered_event.feed_creator = feed.feed_creator
      rendered_event.hours_ago = ((Time.now - feed.created_at) / 1.hour).round
      rendered_event.image = feed.event.image
      rendered_event.creator = feed.event.creator
      rendered_event.details = feed.event.details
      rendered_event.assistants = feed.event.get_visible_assistants(current_user)
      rendered_event.where = feed.event.where
      rendered_event.friendly_date = feed.event.friendly_date
      rendered_event.friendly_hour = feed.event.friendly_hour
      rendered_event.going_label = current_user.get_going_label(feed.event)

      @rendered_events << rendered_event
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

    user_signed_in?

    @event = Event.new(event_params)
    @event.creator = current_user

    respond_to do |format|
      if @event.save
        
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
