class AddsValidColumnToQuizAttempts < ActiveRecord::Migration
  def self.up
    add_column :quiz_attempts, :exclude, :boolean, :default => false, :null => false 
  end

  def self.down
    remove_column :quiz_attempts, :valid
  end
end
