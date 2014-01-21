class User < ActiveRecord::Base
  belongs_to :team
  has_many :lead_couples, class_name: 'Couple', foreign_key: :lead_id, inverse_of: :lead
  has_many :follow_couples, class_name: 'Couple', foreign_key: :follow_id, inverse_of: :follow
  has_many :adjudicators

  has_many :couples, -> {
    joins('JOIN couples ON (couples.lead_id = users.id OR couples.follow_id = users.id)')
      .select('couples.*')
  }, class_name: 'User', foreign_key: 'id'

  has_many :events, class_name: 'Event', finder_sql:
    proc { <<-EOQ
      SELECT 'events'.* FROM 'events'
        INNER JOIN 'couples' ON 'events'.'id' = 'couples'.'event_id'
        WHERE 'couples'.'lead_id' = #{self.id}
          OR 'couples'.'follow_id' = #{self.id}
    EOQ
  }
  has_many :competitions, class_name: 'Competition', finder_sql:
    proc { <<-EOQ
      SELECT 'competitions'.* FROM 'competitions'
        INNER JOIN 'events' ON 'competitions'.'id' = 'events'.'competition_id'
        INNER JOIN 'couples' ON 'events'.'id' = 'couples'.'event_id'
        WHERE 'couples'.'lead_id' = #{self.id}
        OR 'couples'.'follow_id' = #{self.id}
    EOQ
  }

  # Combines the {#first_name} and {#last_name} attributes.
  def name
    "#{first_name} #{last_name}"
  end
end
