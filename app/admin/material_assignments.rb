ActiveAdmin.register MaterialAssignment do
  menu false

  form do |f|
    f.inputs "Details" do
      f.input :assignment_id, :as => :hidden, :input_html => {:value => f.object.assignment_id}
      f.input :task
  		f.input :material
      f.input :qty_sent
      f.input :qty_used
    end

    f.buttons
  end

end
