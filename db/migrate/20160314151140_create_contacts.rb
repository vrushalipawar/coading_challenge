class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.bigint :number

      t.timestamps null: false
    end
  end
end
