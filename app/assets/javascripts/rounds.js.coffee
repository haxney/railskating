jQuery ->
  $('.results_round').dataTable
    bPaginate: false
    bInfo: false
    sDom: 't'
    aoColumnDefs: [
      aTargets: ['recalled_col', 'adjudicator_col', 'placement_col']
      bSearchable: false
    ]

  $('.results_round').floatThead()
