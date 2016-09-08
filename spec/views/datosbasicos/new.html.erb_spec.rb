require 'rails_helper'

RSpec.describe "datosbasicos/new", :type => :view do
  before(:each) do
    assign(:datosbasico, Datosbasico.new(
      :titulo => "MyString",
      :seccion => "MyString",
      :descripcion => "MyText"
    ))
  end

  it "renders new datosbasico form" do
    render

    assert_select "form[action=?][method=?]", datosbasicos_path, "post" do

      assert_select "input#datosbasico_titulo[name=?]", "datosbasico[titulo]"

      assert_select "input#datosbasico_seccion[name=?]", "datosbasico[seccion]"

      assert_select "textarea#datosbasico_descripcion[name=?]", "datosbasico[descripcion]"
    end
  end
end
