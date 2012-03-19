class Location < ActiveRecord::Base
	belongs_to :client
  belongs_to :proposal

	has_many :tasks, :dependent => :destroy
	accepts_nested_attributes_for :tasks, :allow_destroy => true

  attr_accessible :name, :address, :city, :state, :zip, :client_id, :proposal_id, :tasks_attributes
  validates_presence_of :address, :city, :state, :zip
end
