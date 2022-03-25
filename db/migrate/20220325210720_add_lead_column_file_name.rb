class AddLeadColumnFileName < ActiveRecord::Migration[7.0]
  def change
    add_column :leads, :attachment_file_name, :string
  end
end
