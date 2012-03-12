class Employee < ActiveRecord::Base
  before_create :default_number

  belongs_to :department

  has_many :proposals
  has_many :work_orders
  has_many :labor_assignments

  # self-referencing relationships
  belongs_to :supervisor, :foreign_key => "supervisor_id", :class_name => "Employee"
  has_many :employees, :foreign_key => "supervisor_id", :class_name => "Employee"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  scope :management, where("employees.department_id = 1")
  scope :sales, where("employees.department_id = 2")
  scope :labor, where("employees.department_id = 3")

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :number, :name, :phone, :admin, :department_id, :supervisor_id

  validates_presence_of :number, :name, :email, :phone, :department_id

  after_create { |admin| admin.send_reset_password_instructions }

  def password_required?
    new_record? ? false : super
  end

	def admin?
		admin
	end

  def next_id
    if last_emp = Employee.last
      id = last_emp.number
      id.slice!(0)
      count = id.count("0")
      id = (id.to_i + 1).to_s
      for i in 0...count do
        id = "0" + id
      end
      next_id = "E" + id
    else
      next_id = "E001" # first proposal
    end
  end

  def default_number
    self[:number] = self.next_id
  end
end
