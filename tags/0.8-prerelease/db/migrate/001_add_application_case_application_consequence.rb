class AddApplicationCaseApplicationConsequence < ActiveRecord::Migration
  def self.up
    add_column :process_patterns, :application_case, :text
    add_column :process_patterns, :application_consequence, :text
  end

  def self.down
    remove_column :process_patterns, :application_consequence
    remove_column :process_patterns, :application_case
  end
end
