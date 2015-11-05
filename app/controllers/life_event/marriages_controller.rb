module LifeEvent
  class MarriagesController < ApplicationController
    before_action :set_marriage, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :authorize_user

    def new
      @marriage = LifeEvent::Marriage.new(marriage_params)
    end

    def create
      @marriage = LifeEvent::Marriage.new(marriage_params)

      respond_to do |format|
        if @marriage.save
          format.html { redirect_to @marriage, notice: 'Marriage was successfully created.' }
          format.json { render action: 'show', status: :created, location: @marriage }
        else
          format.html { render action: 'new' }
          format.json { render json: @marriage.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
      @marriage.update(marriage_params)

      respond_to do |format|
        if @marriage.save
          format.html { redirect_to @marriage, notice: 'Marriage was successfully updated.' }
          format.json { render action: 'show', status: :updated, location: @marriage }
        else
          format.html { render action: 'edit' }
          format.json { render json: @marriage.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_marriage
      @marriage = LifeEvent::Marriage.find(params[:id])
    end

    def marriage_params
      params.require(:marriage).permit(
        :person_1_id,
        :person_2_id,
        :date
      )
    end
  end
end
