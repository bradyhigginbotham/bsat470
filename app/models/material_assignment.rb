class MaterialAssignment < ActiveRecord::Base
  belongs_to :task
  belongs_to :material
  belongs_to :assignment
end
