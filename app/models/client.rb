class Client < ActiveRecord::Base
	has_many :locations, :dependent => :destroy
  accepts_nested_attributes_for :locations, :allow_destroy => true

	has_many :proposals, :dependent => :destroy
  accepts_nested_attributes_for :proposals, :allow_destroy => true

	validates_presence_of :client_num, :full_name, :email, :billing_address
end
