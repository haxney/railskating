# Helper functions for testing scoring steps.

# These are needed to make re-running work. Only the support files in the subdir
# of the features to be run are loaded, so dependencies need to be required
# explicitly.
require File.dirname(__FILE__) + '/../../support/pickle'
require File.dirname(__FILE__) + '/../../step_definitions/pickle_steps'

# Find or create a model with the given fields.
#
# Since there could be multiple sub rounds within a single round, don't recreate
# the couples or adjudicators in each table.
def find_or_create_model(factory, label, fields)
  name = "#{factory} \"#{label}\""
  find_model(name, fields) or create_model(name, fields)
end

def expect_model_class(model, klass)
  raise UnexpectedModelClass, "Expected a '#{klass}' object, but got '#{model.class}'" unless model.class == klass
end

class UnexpectedModelClass < RuntimeError; end
