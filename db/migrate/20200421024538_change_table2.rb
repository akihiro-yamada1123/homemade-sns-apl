class ChangeTable2 < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.rename :username, :name
     end

    add_column :messages, :post_at, :datetime
  end
end
