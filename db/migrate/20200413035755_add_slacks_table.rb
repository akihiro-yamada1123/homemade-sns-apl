class AddSlacksTable < ActiveRecord::Migration[6.0]
    def change
      create_table :slacks do |t|
        t.integer :token
        t.string :channel
      end
    end
end
