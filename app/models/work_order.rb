class WorkOrder < ActiveRecord::Base
	belongs_to :proposal
	belongs_to :account

	has_one :location, :through => :proposal
	has_many :tasks, :through => :location
end
