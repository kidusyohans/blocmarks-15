class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.bookmark :references
      t.user :references

      t.timestamps null: false
    end
  end
end
