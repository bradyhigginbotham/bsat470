class Invoice < ActiveRecord::Base
  has_one :work_order
end
