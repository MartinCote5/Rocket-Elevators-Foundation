class AddEmailToQuotes < ActiveRecord::Migration[7.0]
  def change
    add_column :quotes, :email, :text
  end
end
