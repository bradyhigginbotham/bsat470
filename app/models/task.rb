class Task < ActiveRecord::Base
	belongs_to :location
	belongs_to :employee
end
