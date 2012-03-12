class Location < ActiveRecord::Base
	belongs_to :proposal

	has_many :tasks, :dependent => :destroy
	accepts_nested_attributes_for :tasks, :allow_destroy => true

  attr_accessible :name, :address, :client_id, :proposal_id
  validates_presence_of :address, :client_id
end
