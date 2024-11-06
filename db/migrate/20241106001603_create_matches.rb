class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.references :fighter1, null: false, foreign_key: { to_table: :fighters }
      t.references :fighter2, null: false, foreign_key: { to_table: :fighters }
      t.integer :fighter1_score, default: 0
      t.integer :fighter2_score, default: 0
      t.integer :fighter1_penalties, default: 0
      t.integer :fighter2_penalties, default: 0
      t.integer :duration, default: 120 # 2 minutes in seconds
      t.integer :status, default: 0
      t.datetime :started_at

      t.timestamps
    end
  end
end