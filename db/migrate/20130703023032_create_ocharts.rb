class CreateOcharts < ActiveRecord::Migration
  def change
    create_table :ocharts do |t|
      t.string :ochart_id
      t.string :department_name
      t.string :parent_id
      t.string :comp_id

      t.timestamps
    end
  end
end
