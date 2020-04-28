class ChangeTable < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :slack_token, :string
    add_column :slack_sets, :username, :string
  end
end
