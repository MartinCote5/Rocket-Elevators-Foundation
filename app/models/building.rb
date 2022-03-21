class Building < ApplicationRecord
    belongs_to :customer
    belongs_to :address
    has_many :building_details
    has_one :battery

    def twilio
        puts 5
    end


    # b= Building.find(10)


    # if Building.find(10).full_name_of_the_technical_contact_for_the_building == "dave"
    #     p "working"
    # end    


    # if b.full_name_of_the_technical_contact_for_the_building == "dave"
    #     p "working"
    # end  

 

end



