class AddSourceToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :source_id, :integer
    add_column :locations, :source_type, :string
  end
end
