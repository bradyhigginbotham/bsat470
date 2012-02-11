class Proposal < ActiveRecord::Base
	belongs_to :client
	belongs_to :account

	has_many :locations, :dependent => :destroy
	has_many :tasks, :through => :locations
  accepts_nested_attributes_for :locations, :allow_destroy => true
  accepts_nested_attributes_for :tasks, :allow_destroy => true
end
