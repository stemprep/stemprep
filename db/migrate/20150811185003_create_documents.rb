class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.string :size
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
