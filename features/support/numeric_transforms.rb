# Convert a numeric argument to an Integer.
Transform( /^(-?\d+)$/) do |number|
  number.to_i
end

Transform(/^table:number/) do |table|
  table.map_column!(:number) {|num| num.to_i }
  table
end

Transform(/^table:couple/) do |table|
  table.map_column!(:couple) {|num| num.to_i }
  table
end
