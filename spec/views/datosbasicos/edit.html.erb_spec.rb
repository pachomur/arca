require 'rails_helper'

RSpec.describe "datosbasicos/edit", :type => :view do
  before(:each) do
    @datosbasico = assign(:datosbasico, Datosbasico.create!(
      :titulo => "MyString",
      :seccion => "MyString",
      :descripcion => "MyText"
    ))
  end

  it "renders the edit datosbasico form" do
    render

    assert_select "form[action=?][method=?]", datosbasico_path(@datosbasico), "post" do

      assert_select "input#datosbasico_titulo[name=?]", "datosbasico[titulo]"

      assert_select "input#datosbasico_seccion[name=?]", "datosbasico[seccion]"

      assert_select "textarea#datosbasico_descripcion[name=?]", "datosbasico[descripcion]"
    end
  end
end
