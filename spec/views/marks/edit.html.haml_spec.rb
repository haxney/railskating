require 'spec_helper'

describe "marks/edit.html.haml" do
  before(:each) do
    @mark = assign(:mark, stub_model(Mark,
      :adjudicator_id => 1,
      :round_id => 1,
      :couple_id => 1,
      :placement => 1
    ))
  end

  it "renders the edit mark form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => marks_path(@mark), :method => "post" do
      assert_select "input#mark_adjudicator_id", :name => "mark[adjudicator_id]"
      assert_select "input#mark_round_id", :name => "mark[round_id]"
      assert_select "input#mark_couple_id", :name => "mark[couple_id]"
      assert_select "input#mark_placement", :name => "mark[placement]"
    end
  end
end
