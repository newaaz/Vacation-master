class CreateVacations < ActiveRecord::Migration[7.0]
  def change
    create_table :vacations do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :admined_by, foreign_key: { to_table: :employees }

      t.date :start_date, null: false
      t.date :end_date, null: false

      t.integer :status, default: 0

      t.timestamps
    end
  end
end
