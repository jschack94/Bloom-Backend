class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email_address
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :profile_pic, :default => 'https://soulcore.com/wp-content/uploads/2018/01/profile-placeholder.png'
      t.string :job_title, :default => ''
      t.string :expertiseArray, :default => ''
      t.string :bio, :default => ''
      t.string :linkedin, :default => ''
      t.string :github, :default => ''
      t.string :personal_website, :default => ''
      t.boolean :mentor_status, :default => false
      t.boolean :will_buy_coffee, :default => false
      t.references :location, foreign_key: true, :default => 1

      t.timestamps
    end
  end
end
