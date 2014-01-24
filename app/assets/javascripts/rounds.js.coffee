jQuery ->
  $('.results_round').dataTable
    bPaginate: false
    bInfo: false
    sDom: 't'
    aoColumnDefs: [
      aTargets: ['recalled_header', 'adjudicator_header']
      bSearchable: false
    ]
