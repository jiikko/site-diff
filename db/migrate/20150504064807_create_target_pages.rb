class CreateTargetPages < ActiveRecord::Migration
  def change
    create_table :target_pages do |t|
      t.string :path, null: false
      t.references :site, null: false

      t.timestamps null: false
    end
  end
end
