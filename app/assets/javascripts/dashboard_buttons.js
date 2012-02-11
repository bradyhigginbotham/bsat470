$(document).ready(function(){
	if (location.href == 'http://localhost:3000/admin') {
		var buttons = '<div class="action_items">' +
										'<span class="action_item">' +
											'<a href="/admin/clients/new">New Client</a>' +
										'</span>&nbsp;' + 
										'<span class="action_item">' +
											'<a href="/admin/proposals/new">New Proposal</a>' +
										'</span>&nbsp;' + 
										'<span class="action_item">' +
											'<a href="/admin/work_orders/new">New Work Order</a>' +
										'</span>' + 
									'</div>'

		$('#titlebar_right').append(buttons)
	}
});

