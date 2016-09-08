require 'rails_helper'

RSpec.describe "datosbasicos/show", :type => :view do
  before(:each) do
    @datosbasico = assign(:datosbasico, Datosbasico.create!(
      :titulo => "Titulo",
      :seccion => "Seccion",
      :descripcion => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Titulo/)
    expect(rendered).to match(/Seccion/)
    expect(rendered).to match(/MyText/)
  end
end
