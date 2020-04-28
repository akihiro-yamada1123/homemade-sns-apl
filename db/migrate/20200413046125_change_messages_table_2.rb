class ChangeMessagesTable2 < ActiveRecord::Migration[6.0]
  def change
      change_table :messages do |t|
       t.rename :slack_id, :sns
      end

      add_column :slacks, :message_id, :integer
  end
end
