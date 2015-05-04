class CreateCapturedVersions < ActiveRecord::Migration
  def change
    create_table :captured_versions do |t|
      t.string :name
      t.references :site, null: false

      t.timestamps null: false
    end
  end
end
