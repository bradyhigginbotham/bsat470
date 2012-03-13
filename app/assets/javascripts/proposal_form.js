function createClientInfoGrid(){
  $("div.proposal_middle").append(
    '<div class="client_information">' +
      '<div class="client_contact">' +
        '<ol>' +
          '<li id="client_header" class="string optional stringish">' +
            '<h6>Contact Information</h6>' +
          '</li><li id="client_email_input" class="string input optional stringish">' +
	          '<label class="label" for="client_email">Email<abbr title="required">*</abbr></label>' +
	          '<input type="text" id="proposal_clients_email" name="client[email]">' +
          '</li><li id="client_phone_input" class="string input optional stringish">' +
	          '<label class="label" for="client_phone">Phone</label>' +
	          '<input type="text" id="proposal_clients_phone" name="client[phone]">' +
          '</li><li id="client_fax_input" class="string input optional stringish">' +
	          '<label class="label" for="client_fax">Fax</label>' +
	          '<input type="text" id="proposal_clients_fax" name="client[fax]">' +
          '</li>' +
        '</ol>' +
      '</div>' +
      '<div class="client_billing">' +
        '<ol>' +
          '<li id="client_header" class="string optional stringish">' +
            '<h6>Billing Information</h6>' +
          '<li id="client_billing_name_input" class="string input optional stringish">' +
	          '<label class="label" for="client_billing_name">Name</label>' +
	          '<input type="text" id="proposal_clients_billing_name" name="client[billing_name]">' +
          '</li><li id="client_billing_address_input" class="string input optional stringish">' +
	          '<label class="label" for="client_billing_address">Address<abbr title="required">*</abbr></label>' +
	          '<input type="text" id="proposal_clients_billing_address" name="client[billing_address]">' +
          '</li>' +
        '</ol>' +
      '</div>' +
      '<input type="hidden" id="proposal_clients_id" name="client[id]">' +
      '<input type="hidden" id="proposal_clients_number" name="client[number]">' +
      '<input type="hidden" id="proposal_clients_name" name="client[name]">' +
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
  $("input#proposal_clients_billing_address").val(client.billing_address);
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
    $.ajax({
      url: "/clients/next_id",
	    data: 'selected=' + $(this).val(),
      type: 'get',
      processData: false,
	    dataType: 'html',
      success: function(data){$("span#client_no").replaceWith('<span id="client_no" class="plain">' + data + '</span>');}
    });

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
      $("span#client_no").replaceWith('<span id="client_no" class="plain">' + $("select.client_list").val() + '</span>');
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
    $("span#client_no").replaceWith('<span id="client_no" class="plain">' + $(this).val() + '</span>');

    $.ajax({
		  url: "/clients/ajax_call?id=" + $(this).val(),
    	data: 'selected=' + $(this).val(),
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
});
