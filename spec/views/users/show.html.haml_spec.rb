require 'spec_helper'

describe "users/show.html.haml" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :first_name => "First Name",
      :last_name => "Last Name",
      :team_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Last Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
