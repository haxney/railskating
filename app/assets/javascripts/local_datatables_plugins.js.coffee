$.fn.dataTableExt.oApi.fnFilterAll = (oSettings, sInput, iColumn, bRegex, bSmart) ->
  for setting in $.fn.dataTableSettings
    setting.oInstance.fnFilter( sInput, iColumn, bRegex, bSmart)
