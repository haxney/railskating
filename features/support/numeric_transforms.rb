# Convert a numeric argument to an Integer.
Transform( /^(-?\d+)$/) do |number|
  number.to_i
end
