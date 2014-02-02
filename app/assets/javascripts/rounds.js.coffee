jQuery ->
  $('.results_round').dataTable
    bPaginate: false
    bInfo: false
    sDom: 't'
    aoColumnDefs: [
      aTargets: ['recalled_col', 'adjudicator_col', 'placement_col',
        'sub_placement_col', 'cumulative_col', 'total_placements_col',
        'dance_col', 'rule_col']
      bSearchable: false
    ]

  $('.results_round').floatThead()
