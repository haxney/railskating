require 'bigdecimal'

module DecimalTruncateToString
  refine BigDecimal do
    # To string with truncation. If the decimal is an integer, then the decimal is
    # hidden, otherwise it is shown, but without scientific notation.
    def to_st
      if frac == 0
        to_i.to_s
      else
        to_s('F')
      end
    end
  end
end
