class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:join, :edit, :create, :update, :destroy]
  layout "internal"

  # POST /events/:id/join
  def join
    @event = set_event

    assistant = Assistant.find_by(event_id: @event.id, user_id: current_user.id)
  
    if assistant
      if @event.creator != current_user
        assistant.destroy
      end
    else
      Assistant.create(event_id: @event.id, user_id: current_user.id)
    end

    # Returns to referer page
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to)
  end 

  # GET /events
  # GET /events.json
  def index
    @event = Event.new
    @events = Event.all.decorate

    @events.collect do |event|
      event.creator = UserDecorator.new(event.creator)
      user_id = current_user.id if current_user
      event.tag = event.is_current_user_going?(user_id) ? "Going" : "Join"
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
    @event = Event.new(event_params)
    @event.creator = current_user

    respond_to do |format|
      if @event.save
        Assistant.create(user_id: current_user.id, event_id: @event.id)
        format.html { redirect_to events_path}
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
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
