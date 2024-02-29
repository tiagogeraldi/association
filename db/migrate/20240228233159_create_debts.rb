class CreateDebts < ActiveRecord::Migration[7.1]
  def change
    create_table :debts do |t|
      t.references :person, null: false, foreign_key: true
      t.float :amount
      t.text :observation

      t.timestamps
    end
  end
end
