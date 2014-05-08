require 'rspec/matchers'

# From https://gist.github.com/bunnymatic/5726011

RSpec::Matchers.define :be_monotonically_increasing do
  match do |actual|
    derivative = actual.each_cons(2).map{|x, y| y <=> x}
    derivative.all?{|v| v >= 0}
  end

  failure_message_for_should do |actual|
    "expected array #{actual.inspect} to be monotonically increasing"
  end

  failure_message_for_should_not do |actual|
    "expected array #{actual.inspect} to not be monotonically increasing"
  end

  description do
    'be monotonically increasing'
  end
end

RSpec::Matchers.define :be_monotonically_decreasing do
  match do |actual|
    derivative = actual.each_cons(2).map{|x, y| y <=> x}
    derivative.all?{|v| v <= 0}
  end

  failure_message_for_should do |actual|
    "expected array #{actual.inspect} to be monotonically decreasing"
  end

  failure_message_for_should_not do |actual|
    "expected array #{actual.inspect} to not be monotonically decreasing"
  end

  description do
    'be monotonically decreasing'
  end
end

RSpec::Matchers.define :be_strictly_increasing do
  match do |actual|
    derivative = actual.each_cons(2).map{|x, y| y <=> x}
    derivative.all?{|v| v > 0}
  end

  failure_message_for_should do |actual|
    "expected array #{actual.inspect} to be strictly increasing"
  end

  failure_message_for_should_not do |actual|
    "expected array #{actual.inspect} to not be strictly increasing"
  end

  description do
    'be strictly increasing'
  end
end

RSpec::Matchers.define :be_strictly_decreasing do
  match do |actual|
    derivative = actual.each_cons(2).map{|x, y| y <=> x}
    derivative.all?{|v| v < 0}
  end

  failure_message_for_should do |actual|
    "expected array #{actual.inspect} to be strictly decreasing"
  end

  failure_message_for_should_not do |actual|
    "expected array #{actual.inspect} to not be strictly decreasing"
  end

  description do
    'be strictly decreasing'
  end
end
