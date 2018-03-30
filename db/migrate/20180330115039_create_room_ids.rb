class CreateRoomIds < ActiveRecord::Migration[5.1]
  def change
    create_table :room_ids do |t|
      t.string :roomid

      t.timestamps
    end
  end
end
