class Building < ApplicationRecord
    belongs_to :customer
    belongs_to :address
    has_many :building_details
    has_one :battery
    has_many :interventions
end



