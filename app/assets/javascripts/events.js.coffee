jQuery ->
  $("#event-filter").keyup ->
    $('.results_round_prelim').dataTable().fnFilterAll(this.value);
