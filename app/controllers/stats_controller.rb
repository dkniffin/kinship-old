class StatsController < ApplicationController
  def show
    render 'stats'
  end

  def gender_distribution
    render json: {
      male: Person.where(gender: Person::MALE).count,
      female: Person.where(gender: Person::FEMALE).count
    }
  end

  def average_lifespan_by_century
    render json: lifespans
  end

  def name_popularity
    render json: {
      first_names: Person.all.group(:first_name).count,
      last_names: Person.all.group(:last_name).count
    }
  end

  private

  # { 19: 66, 20: 80 }
  def lifespans
    Person.all
      .joins(:death)
      .joins(:birth)
      .where.not('deaths.date' => nil)
      .where.not('births.date' => nil)
      .group_by { |p| p.death.date.century }
      .map do |century, people|
        lifespan = people.map{|p| p.age(p.death.date) }.sum / people.count
        { century: century, lifespan: lifespan }
      end
  end
end
