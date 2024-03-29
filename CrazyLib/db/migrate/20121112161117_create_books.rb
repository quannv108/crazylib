class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.integer :total_page
      t.string :topic
      t.text :brief_content
      t.integer :type
      t.date :date_of_storing

      t.timestamps
    end
  end
end
