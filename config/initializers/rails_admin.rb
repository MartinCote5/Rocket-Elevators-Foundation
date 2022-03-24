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

  config.model Building do
    list do
      field :id
      field :address_map do
        formatted_value do
          bindings[:view].link_to("Map", "/geo/#{bindings[:object].id}")
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
    dashboard                     # mandatory
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
