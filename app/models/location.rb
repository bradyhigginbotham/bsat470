class Location < ActiveRecord::Base
	belongs_to :proposal

	has_many :tasks, :dependent => :destroy
	accepts_nested_attributes_for :tasks, :allow_destroy => true
end
