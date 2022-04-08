class Battery < ApplicationRecord
  belongs_to :building
  has_many :columns
  has_many :interventions
end
