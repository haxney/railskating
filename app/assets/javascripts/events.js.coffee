jQuery ->
  $("#event-filter").keyup ->
    filt = this.value
    for setting in $.fn.dataTableSettings
      setting.oInstance.fnFilter(filt)

  $('th.adjudicator_col div').tooltip()
  $('th.placement_col div').tooltip()
