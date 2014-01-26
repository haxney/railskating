# Helper functions for event view features
module EventViewHelper
  # Map from header names to column classes.
  COL_NAME_CLASS_MAP = {
    'Number' => '.couple_number_col',
    'Leader' => '.couple_leader_col',
    'Follower' => '.couple_follower_col',
    'Judge' => '.adjudicator_%s_col.dance_%s',
    'Recalled' => '.recalled_col'
  }

  # Converts a header name to a class name. A header name is one of the
  # following:
  #
  #   - "Number": The couple number column.
  #   - "Leader": The leader name and team column.
  #   - "Follower": The follower name and team column.
  #   - "Judge 'X', Dance": The column for judge "X" in "Dance".
  #   - "Recalled": The recalled column.
  #
  # @param [String] name The column name.
  #
  # @return [String] The CSS class associated with the column name.
  def column_name_to_class(name)
    res = COL_NAME_CLASS_MAP[name.split.first]
    raise "Invalid column name '#{res}'" unless res
    if md = name.match(/Judge '(.+)', (.+)/)
      res % [md[1], md[2].parameterize.underscore]
    else
      res
    end
  end
end

World(EventViewHelper)
