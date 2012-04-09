function ajaxCalls(type, value, form){
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
  } else if (type === "materials_grid") {
    $.ajax({
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
          $.ajax({
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
                createMaterialsGrid(tasks, materials);
              }
            }
	        });
        }
      }
	  });
  } else if (type === "labor_grid") {
    $.ajax({
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
          $.ajax({
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
                createLaborGrid(tasks, labor);
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

    // material_assignments
    if (!$("div.material_assignments").length)
      ajaxCalls("materials_grid", $(this).val(), 'new');

    // labor assignments
    if (!$("div.labor_assignments").length)
      ajaxCalls("labor_grid", $(this).val(), 'new');

  } else {
    clearLocationGrid();
    clearTaskGrid();
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

function createMaterialsGrid(tasks, materials){
  $("fieldset.materials_box").append('<div class="materials_grid"></div>');

  // tasks select box
  $("div.materials_grid").append('<select id="material_assignments_0_task_id" name="material_assignments[0][task_id]"></select>');
  for (var i = 0; i < tasks.length; i++) {
    $("select#material_assignments_0_task_id").append('<option value="' + tasks[i].id + '">' + tasks[i].title + '</option>');
  }

  // materials select box
  $("div.materials_grid").append('<select id="material_assignments_0_material_id" name="material_assignments[0][material_id]"></select>');
  for (var i = 0; i < materials.length; i++) {
    $("select#material_assignments_0_material_id").append('<option value="' + materials[i].id + '">' + materials[i].name + '</option>');
  }
}

function createLaborGrid(tasks, labor){
  $("fieldset.labor_box").append('<div class="labor_grid"></div>');

  // tasks select box
  $("div.labor_grid").append('<select id="labor_assignments_0_task_id" name="labor_assignments[0][task_id]"></select>');
  for (var i = 0; i < tasks.length; i++) {
    $("select#labor_assignments_0_task_id").append('<option value="' + tasks[i].id + '">' + tasks[i].title + '</option>');
  }

  // employee select box
  $("div.labor_grid").append('<select id="labor_assignments_0_employee_id" name="labor_assignments[0][employee_id]"></select>');
  for (var i = 0; i < labor.length; i++) {
    $("select#labor_assignments_0_employee_id").append('<option value="' + labor[i].id + '">' + labor[i].name + '</option>');
  }

}

function showMiddle(){$("div.assignment_middle").show().delay(8000);}
function hideMiddle(){$("div.assignment_middle").hide();}
function showFooter(){$("div.form_footer").show().delay(4000);}
function hideFooter(){$("div.form_footer").hide();}
