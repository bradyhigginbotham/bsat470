class Client < ActiveRecord::Base
	has_many :locations, :dependent => :destroy
  accepts_nested_attributes_for :locations, :allow_destroy => true

	has_many :proposals, :dependent => :destroy
  accepts_nested_attributes_for :proposals, :allow_destroy => true

  attr_accessible	        :number, :name, :email, :phone, :billing_name, :billing_address
  validates_presence_of   :number, :name, :email, :billing_address
  validates_uniqueness_of :number

end
