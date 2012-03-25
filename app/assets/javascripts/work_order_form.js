function ajaxCalls(type, value){
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
          fillLocationList(data);
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
          alert(data.length);
          createTaskGrid(data.length);
          updateTaskGrid(data);
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
    ajaxCalls("location_list", $(this).val());
    showMiddle();
    showFooter();
  } else {
    hideMiddle();
    hideFooter();
  }
});

// when location is selected
$("select.location_list").change(function() {    
  if($(this).val()) {
    if($("div.location_grid").length)
      clearLocationGrid();
    ajaxCalls("location_info", $(this).val());
    ajaxCalls("task_grid", $(this).val());
  } else {
    clearLocationGrid();
    clearTaskGrid();
  }
});

function fillLocationList(data){
  var locations = eval('(' + data + ')');

  $("select.location_list").empty();
  $("select.location_list").append('<option value=""></option>');
  for (var i = 0; i < locations.length; i++) {
    $("select.location_list").append('<option value="' + locations[i].id + '">' + locations[i].name + '</option>');
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

function createTaskGrid(count){
  $("div.wo_tasks").append('<div class="task_fields"></div>');

  for (var i = 0; i < count; i++){
    $("div.wo_tasks .task_fields").append(
      '<ol>' +
        '<li id="work_order_tasks_attributes_0_title_input" class="string input required stringish"><input type="text" name="work_order[tasks_attributes][0][title]" maxlength="255" id="work_order_tasks_attributes_0_title"></li>' +
        '<li id="work_order_tasks_attributes_0_sqft_input" class="number input required numeric stringish"><input type="number" step="any" name="work_order[tasks_attributes][0][sqft]" id="work_order_tasks_attributes_0_sqft"></li>' +
        '<li id="work_order_tasks_attributes_0_price_per_sqft_input" class="number input required numeric stringish"><input type="number" step="any" name="work_order[tasks_attributes][0][price_per_sqft]" id="work_order_tasks_attributes_0_price_per_sqft"></li>' +
        '<li id="work_order_tasks_attributes_0_est_hours_input" class="number input optional numeric stringish"><input type="number" step="any" name="work_order[tasks_attributes][0][est_hours]" id="work_order_tasks_attributes_0_est_hours"></li>' +
        '<li id="work_order_tasks_attributes_0_status_input" class="string input optional stringish"><input type="text" value="Pending" readonly="readonly" name="work_order[tasks_attributes][0][status]" maxlength="255" id="work_order_tasks_attributes_0_status" class="plain"></li>' +
        '<li id="work_order_tasks_attributes_0_date_completed_input" class="string input optional stringish"><input type="text" name="work_order[tasks_attributes][0][date_completed]" id="work_order_tasks_attributes_0_date_completed" class="datepicker hasDatepicker"></li>' +
      '</ol>'
    );
  }
}

function showMiddle(){$("div.wo_middle").show().delay(8000);}
function hideMiddle(){$("div.wo_middle").hide();}
function showFooter(){$("div.form_footer").show().delay(4000);}
function hideFooter(){$("div.form_footer").hide();}
