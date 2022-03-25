class AddFullNameOfTheContactToQuote < ActiveRecord::Migration[7.0]
  def change
    add_column :quotes, :full_name_of_the_contact, :string
  end
end
