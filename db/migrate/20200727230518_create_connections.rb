  class CreateConnections < ActiveRecord::Migration[6.0]
  def change
    create_table :connections do |t|
      t.integer :mentee_id
      t.integer :mentor_id
      t.boolean :accepted, :default => false

      t.timestamps
    end
    
  end
end