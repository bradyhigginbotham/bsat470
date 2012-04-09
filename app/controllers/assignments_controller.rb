class AssignmentsController < ApplicationController
  def ajax_materials
    if @materials = Material.all
			render :json => @materials
		else
			render :text => "record_not_found"
		end
  end

  def ajax_labor
    if @labor = Employee.where("department_id = 3")
			render :json => @labor
		else
			render :text => "record_not_found"
		end
  end
end
