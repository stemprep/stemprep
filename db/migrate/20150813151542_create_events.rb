class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :date
      t.string :title
      t.string :description
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
