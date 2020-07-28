class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.string :text
      t.boolean :opened, :default => false

      t.timestamps
    end
  
  end
end