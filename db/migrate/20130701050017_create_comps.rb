class CreateComps < ActiveRecord::Migration
  def change
    create_table :comps do |t|
      t.string :comp_id
      t.string :comp_name
      t.string :area_code
      t.string :tel
      t.string :www
      t.string :brief

      t.timestamps
    end
  end
end
