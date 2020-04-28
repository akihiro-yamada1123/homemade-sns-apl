class CreateSlackSets < ActiveRecord::Migration[6.0]
  def change
    create_table :slack_sets do |t|
      t.string :token
      t.string :channel
      t.integer :message_id

      t.timestamps
    end
  end
end
