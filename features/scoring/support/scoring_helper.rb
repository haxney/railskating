# Helper functions for testing scoring steps.

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
