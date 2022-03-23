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

  config.model Customer do
    list do
      field :address_map do
        def render
          v = bindings[:views]
          url = "/"
          v.link_to(url)
        end
      end
      fields :id, :address_map, :user_id, :company_name, :address_id, :full_name_of_the_company_contact, :company_contact_phone, :email_of_the_company_contact, :company_description, :full_name_of_service_technical_authority, :technical_authority_phone_for_service, :technical_manager_email_for_service, :created_at, :updated_at
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
