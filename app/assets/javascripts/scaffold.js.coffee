$ ->
  # enable chosen js
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    placeholder_text_multiple: 'Select Developers'
    width: '200px'

  $('.chosen-select-single').chosen
    allow_single_deselect: true
    search_contains: true
    no_results_text: 'No results matched'
    placeholder_text_multiple: 'Select Developers'   
    width: '100% !important' 
    height: '80%'