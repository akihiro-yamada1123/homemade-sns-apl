class ChangeMessagesTable < ActiveRecord::Migration[6.0]
  def change
    change_table :messages do |t|
      t.rename :userid, :user_id
      t.integer :means_id
    end
  end
end
