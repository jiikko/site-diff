class CreateCompositedScreenshots < ActiveRecord::Migration
  def change
    create_table :composited_screenshots do |t|
      t.references :captured_environment_before, null: false
      t.references :captured_environment_after, null: false
      t.attachment :compared_image
      t.integer :averaged_pixel, false: 0
      t.timestamps null: false
    end
    add_index :composited_screenshots, [:captured_environment_before_id, :captured_environment_after_id], name: :comp_a_b_id
    add_index :composited_screenshots, [:captured_environment_after_id, :captured_environment_before_id], name: :comp_b_a_id
  end
end
