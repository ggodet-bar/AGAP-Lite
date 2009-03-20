class CreateProcessPatterns < ActiveRecord::Migration
  def self.up
    create_table :process_patterns do |t|
      t.string  :identifier, :null=>false
      t.string  :author
      t.string  :participant
      t.string  :classification
      t.string  :processContext
      t.string  :productContext
      t.text    :problem
      t.text    :forces
      t.integer :process_image_id
      t.string  :process_model_uri
      t.text    :process_solution
      t.text    :product_solution
      t.string  :uses
      t.string  :requires
      t.string  :alternative
      t.timestamps
    end
  end

  def self.down
    drop_table :process_patterns
  end
end
