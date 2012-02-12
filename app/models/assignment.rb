class Assignment < ActiveRecord::Base
	belongs_to :work_order
	belongs_to :employee
end
