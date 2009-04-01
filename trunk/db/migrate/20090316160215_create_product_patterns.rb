class CreateProductPatterns < ActiveRecord::Migration
  def self.up
    create_table :product_patterns do |t|
        t.string  :identifier, :null=>false
        t.string  :author
        t.string  :classification
        t.text    :problem
        t.text    :forces
        t.integer :product_image_id
        t.string  :product_model_uri
        t.text    :product_solution
        t.string  :uses
        t.string  :requires
        t.string  :alternative
        t.timestamps
    end
  end

  def self.down
    drop_table :product_patterns
  end
end
