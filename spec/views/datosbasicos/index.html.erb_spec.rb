require 'rails_helper'

RSpec.describe "datosbasicos/index", :type => :view do
  before(:each) do
    assign(:datosbasicos, [
      Datosbasico.create!(
        :titulo => "Titulo",
        :seccion => "Seccion",
        :descripcion => "MyText"
      ),
      Datosbasico.create!(
        :titulo => "Titulo",
        :seccion => "Seccion",
        :descripcion => "MyText"
      )
    ])
  end

  it "renders a list of datosbasicos" do
    render
    assert_select "tr>td", :text => "Titulo".to_s, :count => 2
    assert_select "tr>td", :text => "Seccion".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
