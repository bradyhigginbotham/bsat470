class Location < ActiveRecord::Base
  before_create :defaults

	belongs_to :client
  belongs_to :proposal

	has_many :tasks, :dependent => :destroy
	accepts_nested_attributes_for :tasks, :allow_destroy => true

  attr_accessible :name, :address, :city, :state, :zip, :client_id, :proposal_id, :tasks_attributes
  validates_presence_of :name, :address, :city, :state, :zip

  def defaults
    self[:state] = self.state.upcase
    self[:city] = self.city.upcase
  end

end
