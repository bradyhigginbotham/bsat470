class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :title, :null => false
      t.timestamps
    end

    Department.create!(:title => 'Management')
    Department.create!(:title => 'Sales')
    Department.create!(:title => 'Labor')
  end
end
