class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start_time
      t.datetime :end_time
      t.string :url
      t.boolean :editable
      t.boolean :start_editable
      t.boolean :duration_editable
      t.boolean :all_day

      t.belongs_to :user

      t.timestamps null: false
    end
  end
end