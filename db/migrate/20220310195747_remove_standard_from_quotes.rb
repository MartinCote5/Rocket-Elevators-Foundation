class RemoveStandardFromQuotes < ActiveRecord::Migration[7.0]
  def change
    remove_column :quotes, :standard, :string
  end
end
