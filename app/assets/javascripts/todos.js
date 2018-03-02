$(document).on('nested:fieldAdded', function(event){      
    var field = event.field;
    $(field).css("margin-left","7px");    
    var developerField = field.find('#developerId');    
    var removeField = field.find(".remove");
    var taskField = field.find('.task');        
    var developerId_chosen_field = field.find("#developerId_chosen");
    developerField.chosen();    
    taskField.css("margin-left","8px");
    taskField.css("width","98%");
    removeField.css("margin-left","-6px");
    developerId_chosen_field.css("width","305px");    

  })

  $(document).on('nested:fieldRemoved', function(event){
    var field = event.field;
    var taskField = field.find('.task');
    taskField.attr("required",false);
  })