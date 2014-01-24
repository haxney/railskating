jQuery ->
  # Currently, there's an error on final tables
  $('.results_round_prelim').dataTable
    bPaginate: false
    bInfo: false
    sDom: 't'
    aoColumnDefs: [
      aTargets: ['recalled_header', 'adjudicator_header']
      bSearchable: false
    ]
