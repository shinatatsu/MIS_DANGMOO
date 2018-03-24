class CreateKeywordAppings < ActiveRecord::Migration[5.1]
  def change
    create_table :keyword_appings do |t|
      t.string :keyword
      t.string :message

      t.timestamps
    end
  end
end
