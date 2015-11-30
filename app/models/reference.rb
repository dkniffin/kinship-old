class Reference < ActiveRecord::Base
  belongs_to :source
  belongs_to :referenceable, polymorphic: true
end
