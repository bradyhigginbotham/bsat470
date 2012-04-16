function ajaxCalls(type, value, form){
  if (type === "location_list"){
    $.ajax({
		  url: "/locations/list?id=" + value,
    	data: 'selected=' + value,
		  type: 'get',
      processData: false,
    	dataType: 'html',
		  success: function(data){
        if (data == "record_not_found") {
	        alert("An error has occurred.");
          return;
        } else {
          if (form === 'edit') {
            fillLocationList(data, true);
          } else {
            fillLocationList(data, false);
          }
        }
      }
	  });
  } else if (type === "location_info") {
    $.ajax({
		  url: "/locations/ajax_call?id=" + value,
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
          var pending_count = 0;
          for (var i = 0; i < tasks.length; i++){
            if (tasks[i].status == "Pending")
              pending_count++;
          }
          createTaskGrid(tasks.length, pending_count);
          updateTaskGrid(tasks);
        }
      }
	  });
  }
}

// when proposal number is selected
$("select.proposal_list").change(function() {    
  if($(this).val()) {
    if($("div.location_grid").length)
      clearLocationGrid();
    ajaxCalls("location_list", $(this).val(), 'new');
    showMiddle();
    showFooter();
  } else {
    hideMiddle();
    hideFooter();
  }

  if ($("fieldset.wo_task_inputs").length)
    $("fieldset.wo_task_inputs").remove();
});

// when location is selected
$("select.location_list").change(function() {    
  if($(this).val()) {
    if($("div.location_grid").length)
      clearLocationGrid();
    ajaxCalls("location_info", $(this).val(), 'new');

    // tasks
    if (!$("fieldset.wo_task_inputs").length)
      createTaskContainer();
    ajaxCalls("task_grid", $(this).val(), 'new');
  } else {
    clearLocationGrid();
    clearTaskGrid();
  }
});

function fillLocationList(data, isEdit){
  var locations = eval('(' + data + ')');

  $("select.location_list").empty();
  $("select.location_list").append('<option value=""></option>');
  for (var i = 0; i < locations.length; i++) {
    $("select.location_list").append('<option value="' + locations[i].id + '">' + locations[i].name + '</option>');
  }
  if(isEdit){
    setLocation();
    createTaskContainer();
    ajaxCalls("location_info", $('#work_order_location_id').val(), 'new');
    ajaxCalls("task_grid", $('#work_order_location_id').val(), 'new');
  }
}

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

function createTaskContainer(){
  $("fieldset.buttons").before(
    '<fieldset class="inputs wo_task_inputs">' +
      '<legend><span>Tasks</span></legend>' +
      '<div class="container_wo_tasks">' +      
        '<div class="wo_tasks">' +
          '<div class="task_labels">' +
            '<ol>' +
              '<li><label class="label">Task<abbr title="required">*</abbr></label></li>' +
              '<li><label class="label">Square Feet<abbr title="required">*</abbr></label></li>' +
              '<li><label class="label">Price($)/SqFt<abbr title="required">*</abbr></label></li>' +
              '<li><label class="label">Est. Hours</label></li>' +
              '<li><label class="label">Status</label></li>' +
              '<li><label class="label">Completed</label></li>' +
            '</ol>' +
          '</div>' +
        '</div>' +
      '</div>' +
    '</fieldset>'
  );

  
}

function createTaskGrid(count, pending){
  if ($("div.task_fields").length)
    $("div.task_fields").remove();
  $("div.wo_tasks").append('<div class="task_fields"></div>');

  if (pending > 0) {
    for (var i = 0; i < count; i++){
      $("div.wo_tasks .task_fields").append(
        '<ol>' +
          '<li id="tasks_' + i + '_title_input" class="string input required stringish"><input type="text"  name="tasks[' + i + '][title]" maxlength="255" id="tasks_' + i + '_title"></li>' +
          '<li id="tasks_' + i + '_sqft_input" class="number input required numeric stringish"><input type="number" step="any" name="tasks[' + i + '][sqft]" id="tasks_' + i + '_sqft"></li>' +
          '<li id="tasks_' + i + '_price_per_sqft_input" class="number input required numeric stringish"><input type="number" step="any" name="tasks[' + i + '][price_per_sqft]" id="tasks_' + i + '_price_per_sqft"></li>' +
          '<li id="tasks_' + i + '_est_hours_input" class="number input optional numeric stringish"><input type="number" step="any" name="tasks[' + i + '][est_hours]" id="tasks_' + i + '_est_hours"></li>' +
          '<li id="tasks_' + i + '_status_input" class="string input optional stringish"><input type="text"  readonly="readonly" name="tasks[' + i + '][status]" maxlength="255" id="tasks_' + i + '_status"></li>' +
          '<li id="tasks_' + i + '_date_completed_input" class="string input optional stringish"><input type="text" name="tasks[' + i + '][date_completed]" id="tasks_' + i + '_date_completed" disabled="disabled" value="--"></li>' +
          '<input type="hidden" name="tasks[' + i + '][id]" id="tasks_' + i + '_id">' +
          '<input type="hidden" name="tasks[' + i + '][location_id]" id="tasks_' + i + '_location_id">' +
        '</ol>'
      );
    }
  } else {
    for (var i = 0; i < count; i++){
      $("div.wo_tasks .task_fields").append(
        '<ol>' +
          '<li id="tasks_' + i + '_title_input" class="string input required stringish"><input type="text"  name="tasks[' + i + '][title]" maxlength="255" id="tasks_' + i + '_title"></li>' +
          '<li id="tasks_' + i + '_sqft_input" class="number input required numeric stringish"><input type="number" step="any" name="tasks[' + i + '][sqft]" id="tasks_' + i + '_sqft"></li>' +
          '<li id="tasks_' + i + '_price_per_sqft_input" class="number input required numeric stringish"><input type="number" step="any" name="tasks[' + i + '][price_per_sqft]" id="tasks_' + i + '_price_per_sqft"></li>' +
          '<li id="tasks_' + i + '_est_hours_input" class="number input optional numeric stringish"><input type="number" step="any" name="tasks[' + i + '][est_hours]" id="tasks_' + i + '_est_hours"></li>' +
          '<li id="tasks_' + i + '_status_input" class="string input optional stringish">' +
            '<select name="tasks[' + i + '][status]" id="tasks_' + i + '_status">' +
              '<option value="In Progress">In Progress</option>' +
              '<option value="Completed">Completed</option>' +
            '</select>' +
          '</li>' +
          '<li id="tasks_' + i + '_date_completed_input" class="string input optional stringish"><input type="text" name="tasks[' + i + '][date_completed]" id="tasks_' + i + '_date_completed" disabled="disabled" value="--"></li>' +
          '<input type="hidden" name="tasks[' + i + '][id]" id="tasks_' + i + '_id">' +
          '<input type="hidden" name="tasks[' + i + '][location_id]" id="tasks_' + i + '_location_id">' +
        '</ol>'
      );
    }
  }
}

function updateTaskGrid(tasks){
  for (var i = 0; i < tasks.length; i++){
    $("input#tasks_" + i + "_title").val(tasks[i].title);
    $("input#tasks_" + i + "_sqft").val(tasks[i].sqft);
    $("input#tasks_" + i + "_price_per_sqft").val(tasks[i].price_per_sqft);
    $("input#tasks_" + i + "_est_hours").val(tasks[i].est_hours);
    $("input#tasks_" + i + "_id").val(tasks[i].id);
    $("input#tasks_" + i + "_location_id").val(tasks[i].location_id);

    if (tasks[i].status == "Pending") {
      $("input#tasks_" + i + "_status").val(tasks[i].status);
    } else {
      $("select#tasks_" + i + "_status").val(tasks[i].status);

      if (tasks[i].status == "Completed") {
        $("select#tasks_" + i + "_status").replaceWith('<input type="text" readonly="readonly" name="tasks[' + i + '][status]" id="tasks_' + i + '_status" style="color: green">');
        $("input#tasks_" + i + "_status").val(tasks[i].status);
        $("input#tasks_" + i + "_date_completed").val(tasks[i].date_completed);

        $("input#tasks_" + i + "_title").attr("readonly", "readonly");
        $("input#tasks_" + i + "_sqft").attr("readonly", "readonly");
        $("input#tasks_" + i + "_price_per_sqft").attr("readonly", "readonly");
        $("input#tasks_" + i + "_est_hours").attr("readonly", "readonly");


        
      }
    }
  }
}

function showMiddle(){$("div.wo_middle").show().delay(8000);}
function hideMiddle(){$("div.wo_middle").hide();}
function showFooter(){$("div.form_footer").show().delay(4000);}
function hideFooter(){$("div.form_footer").hide();}
