class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.all_day :boolean
      t.start :datetime
      t.end :datetime
      t.url :string
      t.editable :boolean
      t.start_editable :boolean
      t.duration_editable :boolean
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
