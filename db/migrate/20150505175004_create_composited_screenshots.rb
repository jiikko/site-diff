class CreateCompositedScreenshots < ActiveRecord::Migration
  def change
    create_table :composited_screenshots do |t|
      t.references :before_captured_version, index: true, null: false # なくてもいいんだけどSQLを簡単にするため
      t.references :after_captured_version, index:  true, null: false
      t.references :before_captured_environment,          null: false
      t.references :after_captured_environment,            null: false
      t.attachment :compared_image
      t.integer :averaged_pixel, false: 0
      t.timestamps null: false
    end
    add_index :composited_screenshots, [:before_captured_environment_id, :after_captured_environment_id], name: :comp_a_b_id
    add_index :composited_screenshots, [:after_captured_environment_id, :before_captured_environment_id], name: :comp_b_a_id
  end
end
