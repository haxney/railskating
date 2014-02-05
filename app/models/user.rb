class User < ActiveRecord::Base
  belongs_to :team
  has_many :lead_couples, { class_name: 'Couple', foreign_key: :lead_id,
    inverse_of: :lead, dependent: :restrict_with_exception }
  has_many :follow_couples, { class_name: 'Couple', foreign_key: :follow_id,
    inverse_of: :follow, dependent: :restrict_with_exception }
  has_many :adjudicators, dependent: :restrict_with_exception

  def couples
    ct = Couple.arel_table
    Couple.where(ct[:lead_id].eq(id).or(ct[:follow_id].eq(id)))
  end

  def events
    ct = Couple.arel_table
    Event.joins(:couples)
      .where(ct[:lead_id].eq(id).or(ct[:follow_id].eq(id)))
      .distinct
  end

  def competitions
    ct = Couple.arel_table
    Competition.joins(events: :couples)
      .where(ct[:lead_id].eq(id).or(ct[:follow_id].eq(id)))
      .distinct
  end


  # Combines the {#first_name} and {#last_name} attributes.
  def name
    "#{first_name} #{last_name}"
  end
end
