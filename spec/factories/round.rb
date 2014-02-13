FactoryGirl.define do
  sequence(:round_number) { |n| n }

  factory :round do
    requested 6
    cutoff nil

    ignore do
      final false
      event
      number nil
    end

    initialize_with do
      opts = { event: event, final: final }
      opts[:number] = number if number
      opts[:number] ||= generate(:round_number) unless final

      Round.find_or_create_by(opts)
    end
  end
end
