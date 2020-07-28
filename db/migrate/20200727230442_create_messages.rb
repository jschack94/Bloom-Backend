class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :text
      t.references :connection, foreign_key: true
      t.belongs_to :user

      t.timestamps
    end
  end
end