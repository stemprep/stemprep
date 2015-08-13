class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :password_digest
      t.string :program
      t.integer :year
      t.string :building
      t.string :home_town
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
