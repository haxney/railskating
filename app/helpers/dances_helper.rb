module DancesHelper
  def dance_to_class_name(dance)
    "dance_#{dance.name.parameterize.underscore}"
  end
end
