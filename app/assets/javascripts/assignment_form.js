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
  } else if (type === "task_grid") {
    $.ajax({
		  url: "/tasks/ajax_call?id=" + value,
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
          createTaskGrid(tasks.length);
          updateTaskGrid(tasks);
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
    if (!$("fieldset.wo_task_inputs").length)
      createTaskContainer();
    ajaxCalls("task_grid", $(this).val(), 'new');

    // labor assignments
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

function showMiddle(){$("div.assignment_middle").show().delay(8000);}
function hideMiddle(){$("div.assignment_middle").hide();}
function showFooter(){$("div.form_footer").show().delay(4000);}
function hideFooter(){$("div.form_footer").hide();}
