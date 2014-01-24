jQuery ->
  $("#event-filter").keyup ->
    $('.results_round').dataTable().fnFilterAll(this.value);

  $('.adjudicator_header').tooltip()
