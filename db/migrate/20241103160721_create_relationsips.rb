class CreateRelationsips < ActiveRecord::Migration[6.1]
  def change
    create_table :relationsips do |t|

      t.timestamps
    end
  end
end
