module LifeEvent
  class BirthsController < ApplicationController
    before_action :set_birth, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :authorize_user

    decorates_assigned :birth

    def new
      @birth = LifeEvent::Birth.new(birth_params)
    end

    def create
      @birth = LifeEvent::Birth.create(birth_params)

      respond_with @birth, location: -> { person_path(@birth.child) }
    end

    def edit
    end

    def update
      @birth.update(birth_params)

      respond_with @birth, location: -> { person_path(@birth.child) }
    end

    private

    def set_birth
      @birth = LifeEvent::Birth.find(params[:id])
    end

    def birth_params
      params.require(:life_event_birth).permit(
        :child_id,
        :parent_1_id,
        :parent_2_id,
        :date,
        source_ids: []
      )
    end
  end
end
