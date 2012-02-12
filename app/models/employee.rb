class Employee < ActiveRecord::Base
	has_many :tasks
	has_many :assignments
end
