class CreateCompositedScreenshots < ActiveRecord::Migration
  def change
    create_table :composited_screenshots do |t|
      t.references :captured_environment_a, null: false
      t.references :captured_environment_b, null: false
      t.attachment :compared_image
      t.integer :averaged_pixel, false: 0
      t.timestamps null: false
    end
    add_index :composited_screenshots, [:captured_environment_b_id, :captured_environment_a_id], name: :comp_a_b_id
  end
end
