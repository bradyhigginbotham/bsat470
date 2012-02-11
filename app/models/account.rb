class Account < ActiveRecord::Base
	has_many :proposals
	has_many :work_orders

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :full_name, :email, :role, :password, :password_confirmation, :remember_me
	validates_presence_of :full_name, :email, :role

  after_create { |admin| admin.send_reset_password_instructions }

  def password_required?
    new_record? ? false : super
  end

	def admin?
		role != 'Employee'
	end
end
