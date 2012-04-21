# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Employee.create!(:number => 'E001', :name => 'Brady Higginbotham', :phone => '(123) 456-7890', :email => 'brady@insulation.com', :password => 'password', :password_confirmation => 'password', :admin => true, :department_id => "1")
Employee.create!(:number => 'E002', :name => 'CatDog', :phone => '(123) 456-7891', :email => 'sales@insulation.com', :password => 'catdog', :password_confirmation => 'catdog', :admin => true, :department_id => "2")
Employee.create!(:number => 'E003', :name => 'Timmy Turner', :phone => '(123) 456-7892', :email => 'labor@insulation.com', :password => 'timmyt', :password_confirmation => 'timmy', :admin => true, :department_id => "3")

Client.create!(
  number: 'C001', 
  name: 'Capt. James T. Kirk', 
  email: 'james.kirk@starfleet.com', 
  phone: '(111) 010-0001',
  billing_name: 'Starfleet Academy',
  billing_address: '407 Winsor #17',
  city: 'Sausalitos',
  state: 'CA',
  zip: '94965'
)

Location.create!(
  name: 'Starfleet Base - U.S.S. Enterprise', 
  address: '389 Presidio Drive', 
  city: 'San Fransisco',
  state: 'CA',
  zip: '94127',
  client_id: 1,
  proposal_id: 1
)

Proposal.create!(
  number: 'P001', 
  status: 'Pending',
  decision_date: '',
  est_method: 'Walk Through',
  customer_type: 'General Contractor',
  client_id: 1,
  employee_id: 2
)

Task.create!(
  title: 'Repair Hull', 
  status: 'Pending',
  sqft: 1200,
  price_per_sqft: 50.00,
  est_hours: 400,
  date_completed: '',
  location_id: 1,
  work_order_id: ''
)

Task.create!(
  title: 'Clean Windows', 
  status: 'Pending',
  sqft: 357,
  price_per_sqft: 10.50,
  est_hours: 20,
  date_completed: '',
  location_id: 1,
  work_order_id: ''
)

Department.create!(:title => 'Management')
Department.create!(:title => 'Sales')
Department.create!(:title => 'Labor')

Material.create!(name: 'Fiber Glass', unit_cost: 4.00, quantity: 19)
Material.create!(name: 'Metallic Covering', unit_cost: 5.50, quantity: 77)
Material.create!(name: 'Window Cleaner', unit_cost: 2.75, quantity: 46)

Vehicle.create!(make: 'Ford', model: 'F-150', year: '2010', checked_out: 0)
Vehicle.create!(make: 'Nissan', model: 'Titan', year: '2009', checked_out: 0)
Vehicle.create!(make: 'Totoyta', model: 'Prius', year: '2008', checked_out: 0)

