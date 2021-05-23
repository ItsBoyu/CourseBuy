class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :title
      t.monetize :price
      t.integer :status, null: false, default: 0
      t.integer :period, null: false, default: 30
      t.text :slug, index: { unique: true }
      t.text :description
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
