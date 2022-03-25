require 'rails_admin/abstract_model'

RailsAdmin.config do |config|
  config.asset_source = :sprockets


  config.authorize_with do redirect_to main_app.root_path unless current_user.try(:employee?) end
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true
  

  #config.main_app_name = ["Cool app", "BackOffice"]

  config.model Building do
    list do
      field :id
      field :address_map do
        formatted_value do
          bindings[:view].link_to("Map", "/geo")
        end
      end
      field :customer_id
      field :address_id
      field :full_name_of_the_building_administrator
      field :email_of_the_administrator_of_the_building
      field :phone_number_of_the_building_administrator
      field :full_name_of_the_technical_contact_for_the_building
      field :technical_contact_email_for_the_building
      field :technical_contact_phone_for_the_building
      field :created_at
      field :updated_at
    end
  end

  config.actions do
    dashboard do                    # mandatory
      controller do
        proc do
          text_to_synthesize = "Greeting #{current_user.email}. "
          text_to_synthesize += "There are currently #{Elevator.all.count} elevators deployed in the #{Building.all.count} buildings of your #{Customer.all.count} customers. "
          text_to_synthesize += "Currently, #{Elevator.where('status !=  \'Running\'').count} elevators are not in Running Status and are being serviced. "
          text_to_synthesize += "You currently have #{Quote.all.count} quotes awaiting processing. "
          text_to_synthesize += "You currently have #{Lead.all.count} leads in your contact requests. "
          text_to_synthesize += "#{Battery.all.count} Batteries are deployed across #{Address.distinct(:city).count} cities. "
          if params[:text]
            polly = Aws::Polly::Client.new
            @polly_voice = polly.synthesize_speech({
              output_format: 'mp3',
              text: text_to_synthesize,
              voice_id: 'Joanna'
            })
            IO.copy_stream(@polly_voice.audio_stream, "#{params[:text]}.mp3") 
            send_file "#{params[:text]}.mp3"
          else
            @buildings = Building.all
          end
        end
      end
    end
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
