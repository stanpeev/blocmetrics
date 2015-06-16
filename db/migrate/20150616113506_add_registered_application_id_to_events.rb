class AddRegisteredApplicationIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :registered_application_id, :integer
  end
end
