function ajaxCalls(type, value, form, assignment, assignment_index){
  if (type === "location_info") {
    $.ajax({
		  url: "/work_orders/get_location?id=" + value,
    	data: 'selected=' + value,
		  type: 'get',
      processData: false,
    	dataType: 'html',
		  success: function(data){
        if (data == "record_not_found") {
	        alert("An error has occurred.");
          return;
        } else {
          if(!$("div.location_grid").length){
            createLocationGrid();
          }
          updateLocationGrid(data);
        }
      }
	  });
  } else if (type === "assignments_grid") {
    $.ajax({ // get tasks
		  url: "/tasks/assignments_ajax_call?id=" + value,
    	data: 'selected=' + value,
		  type: 'get',
      processData: false,
    	dataType: 'html',
		  success: function(data){
        if (data == "record_not_found") {
	        alert("An error has occurred.");
          return;
        } else {
          var tasks = eval('(' + data + ')');
          $.ajax({ // get materials
		        url: "/assignments/ajax_materials",
          	data: 'selected=' + value,
		        type: 'get',
            processData: false,
          	dataType: 'html',
		        success: function(mat_data){
              if (mat_data == "record_not_found") {
	              alert("An error has occurred.");
                return;
              } else {
                var materials = eval('(' + mat_data + ')');
                $.ajax({ // get labor
		              url: "/assignments/ajax_labor",
                	data: 'selected=' + value,
		              type: 'get',
                  processData: false,
                	dataType: 'html',
		              success: function(labor_data){
                    if (labor_data == "record_not_found") {
	                    alert("An error has occurred.");
                      return;
                    } else {
                      var labor = eval('(' + labor_data + ')');

                      if (!$("div.materials_grid").length) { // first material line
                        createMaterialsGrid();
                        addMaterial(0);
                      }
                      if (!$("div.labor_grid").length) { // first labor line
                        createLaborGrid();
                        addLabor(0);
                      }

                      updateSelectBoxes(tasks, materials, labor, assignment, assignment_index);
                    }
                  }
	              });
              }
            }
	        });
        }
      }
	  });
  }
}

// when a work order is selected
$("select.work_order_list").change(function() {    
  if($(this).val()) {
    if($("div.location_grid").length)
      clearLocationGrid();
    ajaxCalls("location_info", $(this).val(), 'new');

    showMiddle();
    showFooter();

    // material and labor assignments
    ajaxCalls("assignments_grid", $(this).val(), 'new');

  } else {
    clearLocationGrid();
    $('div.materials_grid').remove();
    $('div.labor_grid').remove();
  }
});

function createLocationGrid(){
  $("div.location_information").append('<div class="location_grid"></div>');
}

function updateLocationGrid(data){
  var location = eval('(' + data + ')');

  $("div.location_grid").append(
    location.name     + '<br />' +
    location.address  + '<br />' +
    location.city     + ', ' + location.state.toUpperCase() + ' ' + location.zip
  );
}

function clearLocationGrid(){
  $("div.location_grid").remove();
}


/* --------------- Materials * Labor ----------------- */


function createMaterialsGrid(){
  $("fieldset.material_assignments").append('<div class="materials_grid"></div>');

  $("div.materials_grid").append(
    '<ol class="material_assignment_labels">' +
      '<li><label class="label">Task<abbr title="required">*</abbr></label></li>' +
      '<li><label class="label">Material<abbr title="required">*</abbr></label></li>' +
      '<li><label class="label">Qty Sent<abbr title="required">*</abbr></label></li>' +
      '<li><label class="label">Qty Used</label></li>' +
    '</ol>'
  );
}

function addMaterial(index){
  if (index === 0) {
    $("div.materials_grid").append(
      '<div class="add_material_assignment">' +
        '<a class="button material_assignment_button">Add</a>' +
      '</div>'
    );
  }

  $("div.add_material_assignment").before(
    '<ol id="material_assignment_' + index + '">' +
      '<li><select id="material_assignments_' + index + '_task_id" class="material_assignment_tasks_select_box" name="assignment[material_assignments_attributes][' + index + '][task_id]"></select></li>' +
      '<li><select id="material_assignments_' + index + '_material_id" class="material_assignment_materials_select_box" name="assignment[material_assignments_attributes][' + index + '][material_id]"></select></li>' +
      '<li class="string input required stringish">' +
        '<input type="number" name="assignment[material_assignments_attributes][' + index + '][qty_sent]" maxlength="255" id="material_assignments_' + index + '_qty_sent"></li>' +
      '<li class="string input required stringish">' +
        '<input type="number" name="assignment[material_assignments_attributes][' + index + '][qty_used]" maxlength="255" id="material_assignments_' + index + '_qty_used"></li>' +
    '<input type="hidden" id="material_assignments_' + index + '_assignment_id" name="assignment[material_assignments_attributes][' + index + '][assignment_id]"></li>' +
      '<li class="material_delete">' +
        '<a onClick="deleteMaterial(' + index + ');"><img src="/assets/delete.png" /></a></li>' +
    '</ol>'
  );

  $('a.material_assignment_button').attr('onClick', 'addMaterial(' + (index+1) + ');');

  if (index > 0)
    ajaxCalls("assignments_grid", $("select.work_order_list").val(), 'new', 'material', index);
}

function createLaborGrid(){
  $("fieldset.labor_assignments").append('<div class="labor_grid"></div>');

  $("div.labor_grid").append(
    '<ol class="labor_assignment_labels">' +
      '<li><label class="label">Task<abbr title="required">*</abbr></label></li>' +
      '<li><label class="label">Employee<abbr title="required">*</abbr></label></li>' +
      '<li><label class="label">Rate<abbr title="required">*</abbr></label></li>' +
      '<li><label class="label">Est. Hours<abbr title="required">*</abbr></label></li>' +
      '<li><label class="label">Hours Used</label></li>' +
    '</ol>'
  );
}

function addLabor(index){
  if (index === 0) {
    $("div.labor_grid").append(
      '<div class="add_labor_assignment">' +
        '<a class="button labor_assignment_button" onClick="addLabor(' + (index+1) + ');">Add</a>' +
      '</div>'
    );
  }

  $("div.add_labor_assignment").before(
    '<ol id="labor_assignment_' + index + '">' +
      '<li><select id="labor_assignments_' + index + '_task_id" class="labor_assignment_tasks_select_box" name="assignment[labor_assignments_attributes][' + index + '][task_id]"></select></li>' +
      '<li><select id="labor_assignments_' + index + '_employee_id" class="labor_assignment_employees_select_box" name="assignment[labor_assignments_attributes][' + index + '][employee_id]"></select></li>' +
      '<li class="string input required stringish">' +
        '<input type="number" name="assignment[labor_assignments_attributes][' + index + '][rate]" maxlength="255" id="labor_assignments_' + index + '_rate"></li>' +
      '<li class="string input required stringish">' +
        '<input type="number" name="assignment[labor_assignments_attributes][' + index + '][est_hours]" maxlength="255" id="labor_assignments_' + index + '_est_hours"></li>' +
      '<li class="string input required stringish">' +
        '<input type="number" name="assignment[labor_assignments_attributes][' + index + '][used_hours]" maxlength="255" id="labor_assignments_' + index + '_used_hours"></li>' +
    '<input type="hidden" id="labor_assignments_' + index + '_assignment_id" name="assignment[labor_assignments_attributes][' + index + '][assignment_id]"></li>' +
      '<li class="labor_delete">' +
        '<a onClick="deleteLabor(' + index + ');"><img src="/assets/delete.png" /></a></li>' +
    '</ol>'
  );

  $('a.labor_assignment_button').attr('onClick', 'addLabor(' + (index+1) + ');');

  if (index > 0)
    ajaxCalls("assignments_grid", $("select.work_order_list").val(), 'new', 'labor', index);

}

function updateSelectBoxes(tasks, materials, labor, type, index) {
  switch (type) {
    default:
      $("div.materials_grid select option").remove();
      $("div.labor_grid select option").remove();

      // fill tasks select boxes
      for (var i = 0; i < tasks.length; i++) {
        $("select.material_assignment_tasks_select_box").append('<option value="' + tasks[i].id + '">' + tasks[i].title + '</option>');
        $("select.labor_assignment_tasks_select_box").append('<option value="' + tasks[i].id + '">' + tasks[i].title + '</option>');
      }

      // fill materials select box
      for (var i = 0; i < materials.length; i++) {
        $("select.material_assignment_materials_select_box").append('<option value="' + materials[i].id + '">' + materials[i].name + '</option>');
      }

      // fill employees select box
      for (var i = 0; i < labor.length; i++) {
        $("select.labor_assignment_employees_select_box").append('<option value="' + labor[i].id + '">' + labor[i].name + '</option>');
      }
      break;

    case 'material':
      for (var i = 0; i < tasks.length; i++) {
        $("select#material_assignments_" + index + "_task_id").append('<option value="' + tasks[i].id + '">' + tasks[i].title + '</option>');
      }

      for (var i = 0; i < materials.length; i++) {
        $("select#material_assignments_" + index + "_material_id").append('<option value="' + materials[i].id + '">' + materials[i].name + '</option>');
      }
      break;

    case 'labor':
      for (var i = 0; i < tasks.length; i++) {
        $("select#labor_assignments_" + index + "_task_id").append('<option value="' + tasks[i].id + '">' + tasks[i].title + '</option>');
      }

      for (var i = 0; i < materials.length; i++) {
        $("select#labor_assignments_" + index + "_employee_id").append('<option value="' + labor[i].id + '">' + labor[i].name + '</option>');
      }
      break;
  }
}

function deleteMaterial(index) {$('div.materials_grid ol#material_assignment_' + index).remove();}
function deleteLabor(index) {$('div.labor_grid ol#labor_assignment_' + index).remove();}

function showMiddle(){$("div.assignment_middle").show().delay(8000);}
function hideMiddle(){$("div.assignment_middle").hide();}
function showFooter(){$("div.form_footer").show().delay(4000);}
function hideFooter(){$("div.form_footer").hide();}
