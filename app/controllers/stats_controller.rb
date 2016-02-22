class StatsController < ApplicationController
  def gender_distribution
    render json: {
      male: Person.where(gender: Person::MALE).count,
      female: Person.where(gender: Person::FEMALE).count
    }
  end

  def average_lifespan_by_century
    render json: lifespans
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
        [century, people.map{|p| p.age(p.death.date) }.sum / people.count]
      end
      .to_h
  end

  # def stats
  #   # For surname word cloud
  #   surnameCount = {}
  #   Person.all.each{|person|
  #     surnameCount[person.last_name] = (surnameCount[person.last_name] || 0) + 1
  #   }
  #
  #   @surname_word_data = []
  #   surnameCount.each{|key, value|
  #     @surname_word_data.push({key: key, value: value})
  #   }
  #
  #   @surname_word_data = JSON.generate(@surname_word_data)
  #   # For first name word cloud
  #   first_nameCount = {}
  #   Person.all.each{|person|
  #     first_nameCount[person.first_name] = (first_nameCount[person.first_name] || 0) + 1
  #   }
  #
  #   @first_name_word_data = []
  #   first_nameCount.each{|key, value|
  #     @first_name_word_data.push({key: key, value: value})
  #   }
  #
  #   @first_name_word_data = JSON.generate(@first_name_word_data)
  # end

end
