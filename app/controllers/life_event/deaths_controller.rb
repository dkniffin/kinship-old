module LifeEvent
  class DeathsController < ApplicationController
    before_action :set_death, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :authorize_user

    decorates_assigned :death

    def new
      @death = LifeEvent::Death.new(death_params)
    end

    def create
      @death = LifeEvent::Death.create(death_params)

      respond_with @death, location: -> { person_path(@death.person) }
    end

    def edit
    end

    def update
      @death.update(death_params)

      respond_with @death, location: -> { person_path(@death.person) }
    end

    private

    def set_death
      @death = LifeEvent::Death.find(params[:id])
    end

    def death_params
      params.require(:life_event_death).permit(
        :person_id,
        :cause,
        :date,
        source_ids: []
      )
    end
  end
end
