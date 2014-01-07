# Helper functions for testing scoring steps.

def find_or_create_adjudicator(header, competition)
  Adjudicator.where(shorthand: header, competition: competition).take or
    FactoryGirl.create(:adjudicator, shorthand: header, competition: competition)
end

def find_or_create_couple(num, round)
  c = Couple.where(number: num, event: round.event).take ||
    FactoryGirl.create(:couple, number: num, event: round.event)
  round.couples << c
  c
end

def expect_model_class(model, klass)
  raise UnexpectedModelClass, "Expected a '#{klass}' object, but got '#{model.class}'" unless model.class == klass
end
