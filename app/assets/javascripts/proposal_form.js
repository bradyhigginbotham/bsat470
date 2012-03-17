function ajaxCalls(type, value){
  if (type === "next_id"){
    $.ajax({
      url: "/clients/next_id",
	    data: 'selected=' + value,
      type: 'get',
      processData: false,
	    dataType: 'html',
      success: function(data){$("span#client_no").replaceWith('<span id="client_no" class="plain">' + data + '</span>');}
    });
  } else if (type === "client_info") {
    $.ajax({
		  url: "/clients/ajax_call?id=" + value,
    	data: 'selected=' + value,
		  type: 'get',
      processData: false,
    	dataType: 'html',
		  success: function(data){
        if (data == "record_not_found") {
	        alert("An error has occurred.");
          return;
        } else {
          if($("div.client_information").length == 0){
            createClientInfoGrid();
            showFooter();
          }
          updateClientInfo(data);
        }
      }
	  });
  }
}

function createClientInfoGrid(){
  $("div.proposal_middle").append(
    '<div class="client_information">' +
      '<div class="client_contact">' +
        '<ol>' +
          '<li id="client_header" class="string optional stringish">' +
            '<h6>Contact Information</h6>' +
          '</li><li id="client_email_input" class="string input optional stringish">' +
	          '<label class="label" for="client_email">Email<abbr title="required">*</abbr></label>' +
	          '<input type="text" id="proposal_clients_email" name="proposal[clients_attributes][0][email]">' +
          '</li><li id="client_phone_input" class="string input optional stringish">' +
	          '<label class="label" for="client_phone">Phone</label>' +
	          '<input type="text" id="proposal_clients_phone" name="proposal[clients_attributes][0][phone]">' +
          '</li><li id="client_fax_input" class="string input optional stringish">' +
	          '<label class="label" for="client_fax">Fax</label>' +
	          '<input type="text" id="proposal_clients_fax" name="proposal[clients_attributes][0][fax]">' +
          '</li>' +
        '</ol>' +
      '</div>' +
      '<div class="client_billing">' +
        '<ol>' +
          '<li id="client_header" class="string optional stringish">' +
            '<h6>Billing Information</h6>' +
          '<li id="client_billing_name_input" class="string input optional stringish">' +
	          '<label class="label" for="client_billing_name">Name</label>' +
	          '<input type="text" id="proposal_clients_billing_name" name="proposal[clients_attributes][0][billing_name]">' +
          '</li><li id="client_billing_address_input" class="string input optional stringish">' +
	          '<label class="label" for="client_billing_address">Address<abbr title="required">*</abbr></label>' +
	          '<input type="text" id="proposal_clients_billing_address" name="proposal[clients_attributes][0][billing_address]">' +
          '</li>' +
        '</ol>' +
      '</div>' +
      '<input type="hidden" id="proposal_clients_id" name="proposal[clients_attributes][0][id]">' +
      '<input type="hidden" id="proposal_clients_number" name="proposal[clients_attributes][0][number]">' +
      '<input type="hidden" id="proposal_clients_name" name="proposal[clients_attributes][0][name]">' +
    '</div>'
  );
}

function updateClientInfo(data){
  var client = eval('(' + data + ')');

  $("input#proposal_clients_id").val(client.id);
  $("input#proposal_clients_number").val(client.number);
  $("input#proposal_clients_name").val(client.name);
  $("input#proposal_clients_email").val(client.email);
  $("input#proposal_clients_phone").val(client.phone);
  $("input#proposal_clients_fax").val(client.fax);
  $("input#proposal_clients_billing_name").val(client.billing_name);
  $("input#proposal_clients_billing_address").attr("value", client.billing_address);
  $("span#client_no").replaceWith('<span id="client_no" class="plain">' + client.number + '</span>');
}

function clearClientInfo(){
  $("input#client_email").val('');
  $("input#client_phone").val('');
  $("input#client_fax").val('');
  $("input#client_billing_name").val('');
  $("input#client_billing_address").val('');
}

function showFooter(){$("div.form_footer").show().delay(4000);}
function hideFooter(){$("div.form_footer").hide();}

$("form input[type=radio]").click(function() {
  if($(this).val() == "new") {
    ajaxCalls("next_id", $(this).val());

    if(!$("select.client_list").attr('disabled'))
      $("select.client_list").attr('disabled', 'disabled');

    if($("div.client_information").length == 0){
      createClientInfoGrid();
      showFooter();
    } else {
      clearClientInfo();
    }
  }

  if($(this).val() == "existing") {
    $("select.client_list").removeAttr('disabled');

    if($("select.client_list").val())
      ajaxCalls("client_info", $("select.client_list").val());
  }
});

$("select.client_list").change(function() {    
  if(!$(this).val()) {
    $("span#client_no").replaceWith('<span id="client_no" class="plain">-</span>');
    if($("div.client_information").length > 0) {
      $("div.client_information").remove();
      hideFooter();
    }
  } else {
    ajaxCalls("client_info", $(this).val());
  }
});




// Locations and Tasks
function addLocation(index){
  $("#locations_box").append(
    '<div class="locations_' + index + '">' +
      '<div class="location_fields">' +
        '<ol>' +
		      '<li id="proposal_locations_attributes_' + index + '_name_input" class="string input optional stringish">' +
            '<label for="proposal_locations_attributes_' + index + '_name" class=" label">Name</label>' +
            '<input type="text" name="proposal[locations_attributes][' + index + '][name]" maxlength="255" id="proposal_locations_attributes_' + index + '_name">' +
          '</li>' +
		      '<li id="proposal_locations_attributes_' + index + '_address_input" class="string input required stringish">' +
            '<label for="proposal_locations_attributes_' + index + '_address" class=" label">Address<abbr title="required">*</abbr></label>' +
            '<input type="text" name="proposal[locations_attributes][' + index + '][address]" maxlength="255" id="proposal_locations_attributes_' + index + '_address">' +
          '</li>' +
          '<li id="proposal_locations_attributes_' + index + '_client_id_input" class="hidden input optional">' +
            '<input type="hidden" name="proposal[locations_attributes][' + index + '][client_id]" id="proposal_locations_attributes_' + index + '_client_id">' +
          '</li>' +
        '</ol>' +
      '</div>' +
      '<div class="tasks_' + index + '">' +
        '<div class="task_labels">' +
          '<ol>' +
            '<li><label class="label">Task</label></li>' +
            '<li><label class="label">Square Feet</label></li>' +
            '<li><label class="label">Price/SqFt</label></li>' +
            '<li><label class="label">Est. Hours</label></li>' +
          '</ol>' +
        '</div>' +
        '<div class="task_fields">' +
          '<ol>' +
		        '<li id="proposal_locations_attributes_' + index + '_tasks_attributes_0_title_input" class="string input required stringish">' +
              '<input type="text" name="proposal[locations_attributes][' + index + '][tasks_attributes][0][title]" maxlength="255" id="proposal_locations_attributes_' + index + '_tasks_attributes_0_title"></li>' +
			      '<li id="proposal_locations_attributes_' + index + '_tasks_attributes_0_sqft_input" class="number input optional numeric stringish">' +
              '<input type="number" step="any" name="proposal[locations_attributes][' + index + '][tasks_attributes][0][sqft]" id="proposal_locations_attributes_' + index + '_tasks_attributes_0_sqft"></li>' +
			      '<li id="proposal_locations_attributes_' + index + '_tasks_attributes_0_price_per_sqft_input" class="number input optional numeric stringish">' +
              '<input type="number" step="any" name="proposal[locations_attributes][' + index + '][tasks_attributes][0][price_per_sqft]" id="proposal_locations_attributes_' + index + '_tasks_attributes_0_price_per_sqft"></li>' +
			      '<li id="proposal_locations_attributes_' + index + '_tasks_attributes_0_est_hours_input" class="number input optional numeric stringish">' +
              '<input type="number" step="any" name="proposal[locations_attributes][' + index + '][tasks_attributes][0][est_hours]" id="proposal_locations_attributes_' + index + '_tasks_attributes_0_est_hours"></li>' +
          '</ol>' +
        '</div>' +
        '<div class="add_task">' +
          '<a class="button task_button_' + index + '" onClick="addTask(' + index + ', 1);">Add Task</a>' +
        '</div>' +
      '</div>' +
    '</div>'
  );

  $(".add_location a.button").attr("onClick", "addLocation(" + (index+1) + ");");
}

function addTask(location_index, task_index){
  $("div.tasks_" + location_index + " > div.task_fields").append(
      '<ol>' +
        '<li id="proposal_locations_attributes_' + location_index + '_tasks_attributes_' + task_index + '_title_input" class="string input required stringish">' +
          '<input type="text" name="proposal[locations_attributes][' + location_index + '][tasks_attributes][' + task_index + '][title]" maxlength="255" id="proposal_locations_attributes_' + location_index + '_tasks_attributes_' + task_index + '_title"></li>' +
        '<li id="proposal_locations_attributes_' + location_index + '_tasks_attributes_' + task_index + '_sqft_input" class="number input optional numeric stringish">' +
          '<input type="number" step="any" name="proposal[locations_attributes][' + location_index + '][tasks_attributes][' + task_index + '][sqft]" id="proposal_locations_attributes_' + location_index + '_tasks_attributes_' + task_index + '_sqft"></li>' +
        '<li id="proposal_locations_attributes_' + location_index + '_tasks_attributes_' + task_index + '_price_per_sqft_input" class="number input optional numeric stringish">' +
          '<input type="number" step="any" name="proposal[locations_attributes][' + location_index + '][tasks_attributes][' + task_index + '][price_per_sqft]" id="proposal_locations_attributes_' + location_index + '_tasks_attributes_' + task_index + '_price_per_sqft"></li>' +
        '<li id="proposal_locations_attributes_' + location_index + '_tasks_attributes_' + task_index + '_est_hours_input" class="number input optional numeric stringish">' +
          '<input type="number" step="any" name="proposal[locations_attributes][' + location_index + '][tasks_attributes][' + task_index + '][est_hours]" id="proposal_locations_attributes_' + location_index + '_tasks_attributes_' + task_index + '_est_hours"></li>' +
      '</ol>'
  );

  $("div.tasks_" + location_index + " > .add_task > a.task_button_" + location_index).attr("onClick", "addTask(" + location_index + ", " + (task_index+1) + ");");
}










