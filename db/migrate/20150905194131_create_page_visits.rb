class CreatePageVisits < ActiveRecord::Migration
  def change
    create_table :page_visits do |t|
      t.integer :view_count, default: 0
      t.integer :new_user_count, default: 0

      t.timestamps null: false
    end
  end
end
