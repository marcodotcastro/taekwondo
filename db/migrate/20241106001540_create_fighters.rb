class CreateFighters < ActiveRecord::Migration[7.1]
  def change
    create_table :fighters do |t|
      t.string :name, null: false
      t.string :category
      t.integer :weight
      t.text :bio

      t.timestamps
    end
  end
end