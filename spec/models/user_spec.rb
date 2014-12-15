require 'rails_helper'

describe Competition do
  let(:user) { create(:user) }
  describe '#couples' do
    it "returns associated couples, whether leader or follower" do
      lead = create(:couple, lead: user)
      follow = create(:couple, follow: user)

      expect(user.couples).to include(lead, follow)
    end
  end

  describe '#events' do
    it "returns associated events" do
      e1 = create(:event)
      e1.couples << create(:couple, lead: user)

      e2 = create(:event)
      e2.couples << create(:couple, follow: user)

      expect(user.events).to include(e1, e2)
    end
  end

  describe '#competitions' do
    it "returns associated competitions" do
      e1 = create(:event, competition: create(:competition))
      e1.couples << create(:couple, lead: user)

      e2 = create(:event, competition: create(:competition))
      e2.couples << create(:couple, follow: user)

      expect(user.competitions).to include(e1.competition, e2.competition)
    end
  end
end
