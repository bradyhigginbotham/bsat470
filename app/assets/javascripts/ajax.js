$(".client_id").change(function() {
    
    var value = $(this).val();
    
    var title = $(this).children('option[value='+value+']').html();
      
   // $('input#client_billing_name').val(title);

    $.ajax({
			url: "/clients/ajax_update?id=" + value,
    	data: 'selected=' + this.value,
			type: 'get',
      processData: false,
    	dataType: 'html',
			success: function(data) {
    	  if (data == "record_not_found") {
    	  	alert("Record not found");
    	  }
    	  else {
					var client = eval('(' + data + ')');
					$("#proposal_client_id").parent().append(
						'<li id="client_billing_name_input" class="string input optional stringish">' +
							'<label class="label" for="client_billing_name">Billing Name</label>' +
							'<input type="text" id="client_billing_name" name="client[billing_name]">' +
						'</li><li id="client_billing_address_input" class="string input optional stringish">' +
							'<label class="label" for="client_billing_address">Billing Address</label>' +
							'<input type="text" id="client_billing_address" name="client[billing_address]"></li>');
    	  	$("input#client_billing_name").val(client.billing_name);
    	  	$("input#client_billing_address").val(client.billing_address);
					$("input#client_billing_name").prop('disabled', true);
    	  }
			}
  	})
});
