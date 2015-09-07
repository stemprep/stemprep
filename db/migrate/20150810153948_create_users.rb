class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :password_digest
      t.string :city
      t.string :state
      t.string :grade
      t.string :major
      t.string :birthday
      t.boolean :admin
      t.string :prof_pic_url

      t.timestamps null: false
    end
  end
end
