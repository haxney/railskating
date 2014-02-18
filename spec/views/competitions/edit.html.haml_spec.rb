require 'spec_helper'

describe 'competitions/edit' do
  before(:each) do
    @competition = assign(:competition, stub_model(Competition))
  end

  it 'renders the edit competition form' do
    render
    assert_select 'form[action=?][method=?]', competition_path(@competition), 'post' do
    end
  end
end
