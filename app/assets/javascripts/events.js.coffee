jQuery ->
  $("#event-filter").keyup ->
    filt = this.value
    for setting in $.fn.dataTableSettings
      setting.oInstance.fnFilter(filt)

  $('.adjudicator_header').tooltip()
