class CreateDangmoos < ActiveRecord::Migration[5.1]
  def change
    create_table :dangmoos do |t|
      t.string :roomid
      t.string :dangmoo

      t.timestamps
    end
  end
end
