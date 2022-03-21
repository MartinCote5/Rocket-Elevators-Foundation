class ChangeLeadsBinaryFile < ActiveRecord::Migration[7.0]
  def change
    change_column :leads, :attached_file_stored_as_a_binary_file, :binary
  end
end
