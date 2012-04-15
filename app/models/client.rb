class Client < ActiveRecord::Base
  before_create :defaults

	has_many :locations, :dependent => :destroy
  accepts_nested_attributes_for :locations, :allow_destroy => true

	has_many :proposals, :dependent => :destroy
  accepts_nested_attributes_for :proposals, :allow_destroy => true

  attr_accessible	        :number, :name, :email, :phone, :billing_name, :billing_address, :city, :state, :zip
  validates_presence_of   :number, :name, :email, :billing_address, :city, :state, :zip
  validates_uniqueness_of :number

  def defaults
    self[:state] = self.state.upcase
    self[:city] = self.city.titleize
  end

end
