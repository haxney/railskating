jQuery ->
  $("#event-filter").keyup ->
    $('.results_round').dataTable().fnFilterAll(this.value);
