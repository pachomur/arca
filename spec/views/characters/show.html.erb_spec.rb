require 'rails_helper'

RSpec.describe "characters/show", :type => :view do
  before(:each) do
    @character = assign(:character, Character.create!(
      :name => "Name",
      :biography => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
