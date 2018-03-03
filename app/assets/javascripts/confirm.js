function confirm(param,id,obj){
	bootbox.confirm({
    title: "Delete "+toTitleCase(param)+"?",
    message: "Do you really want to delete this "+param+"? This cannot be undone.",
    buttons: {
        cancel: {
            label: '<i class="fa fa-times"></i> No',
            className: 'btn btn-danger btn-sm'
        },
        confirm: {
            label: '<i class="fa fa-check"></i> Yes',
            className: 'btn btn-success btn-sm'
        }
    },
    callback: function (result) {        
        if (result){
        	$.ajax({
				    type: "DELETE",
				    url: '/'+param+'s/'+id,
				    dataType: "JSON",				    
				    success:function(data) {				      				     
				      $(obj).closest("tr").remove();
				      bootbox.alert({size: "small",title: "<i class='fa fa-check'></i> Success!",message: toTitleCase(param)+" deleted successfully!"}).find('.modal-header').css({"background-color":"#1AAF5D"});			      
				    }
				  });
        }
    }
});
}

function toTitleCase(str) {
  return str.replace(/(?:^|\s)\w/g, function(match) {
      return match.toUpperCase();
  });
}