class LifeEventsController < ApplicationController
  before_action :set_life_event, only: [:show, :edit, :update, :destroy]

  # GET /life_events
  # GET /life_events.json
  def index
    @life_events = LifeEvent.all
  end

  # GET /life_events/1
  # GET /life_events/1.json
  def show
  end

  # GET /life_events/new
  def new
    @life_event = LifeEvent.new
  end

  # GET /life_events/1/edit
  def edit
  end

  # POST /life_events
  # POST /life_events.json
  def create
    @life_event = LifeEvent.new(life_event_params)

    respond_to do |format|
      if @life_event.save
        format.html { redirect_to @life_event, notice: 'Life event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @life_event }
      else
        format.html { render action: 'new' }
        format.json { render json: @life_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /life_events/1
  # PATCH/PUT /life_events/1.json
  def update
    respond_to do |format|
      if @life_event.update(life_event_params)
        format.html { redirect_to @life_event, notice: 'Life event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @life_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /life_events/1
  # DELETE /life_events/1.json
  def destroy
    @life_event.destroy
    respond_to do |format|
      format.html { redirect_to life_events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_life_event
      @life_event = LifeEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def life_event_params
      params.require(:life_event).permit(:date, :end_date, :other_attributes, :place_id, :person_id)
    end
end
