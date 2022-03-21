class AddRangeToQuotes < ActiveRecord::Migration[7.0]
  def change
    add_column :quotes, :range, :integer
  end
end
