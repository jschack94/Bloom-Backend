class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :mentee_id
      t.integer :mentor_id
      t.boolean :accepted, :default => false

      t.timestamps
    end
    add_index :relationships, :mentee_id
    add_index :relationships, :mentor_id
    add_index :relationships, [:mentee_id, :mentor_id], unique: true
  end
end