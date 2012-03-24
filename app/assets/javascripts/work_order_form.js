function ajaxCalls(type, value){
  if (type === "next_id"){
    $.ajax({
      url: "/clients/next_id",
	    data: 'selected=' + value,
      type: 'get',
      processData: false,
	    dataType: 'html',
      success: function(data){$("input#proposal_clients_number").val(data);}
    });
  } else if (type === "location_list") {
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
          fillLocationsList(data);
        }
      }
	  });
  }
}

$("select.proposal_list").change(function() {    
  if($(this).val()) {
    ajaxCalls("location_list", $(this).val());
    showMiddle();
    showFooter();
  } else {
    hideMiddle();
    hideFooter();
  }
});

function fillLocationsList(data){
  var locations = eval('(' + data + ')');

  for (var i = 0; i < locations.length; i++) {
    $("select.locations_list").append('<option value="' + locations[i].id + '">' + locations[i].name + '</option>');
  }
}

function showMiddle(){$("div.wo_middle").show().delay(4000);}
function hideMiddle(){$("div.wo_middle").hide();}
function showFooter(){$("div.form_footer").show().delay(4000);}
function hideFooter(){$("div.form_footer").hide();}
