class AddMessagesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.integer :userid
      t.string :message
    end
  end
end
